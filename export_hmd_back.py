import os

import bpy
import mathutils
import bpy_extras.io_utils
from . import exporter

from progress_report import ProgressReport, ProgressReportSubstep

def mesh_triangulate(me):
    import bmesh
    bm = bmesh.new()
    bm.from_mesh(me)
    bmesh.ops.triangulate(bm, faces=bm.faces)
    bm.to_mesh(me)
    bm.free()

def veckey3d(v):
    return round(v[0], 4), round(v[1], 4), round(v[2], 4)

def save(context, filepath,
        EXPORT_APPLY_MODIFIERS = True):
    with ProgressReport(context.window_manager) as progress:
        scene = context.scene
        if bpy.ops.object.mode_set.poll():
            bpy.ops.object.mode_set(mode='OBJECT')
        
        frame = scene.frame_current
        scene.frame_set(frame, 0.0)
        objects = scene.objects

        nscene = exporter.io_Scene ()

        for i, ob_main in enumerate(objects):            
            obs = [(ob_main, ob_main.matrix_world)]            

            for ob, ob_mat in obs:
                nmodel = exporter.io_Model ()
                try:
                    me = ob.to_mesh(scene, EXPORT_APPLY_MODIFIERS, 'PREVIEW', calc_tessface=False)
                except:
                    continue

                ngeom = exporter.io_Geometry ()
                ngeom.hasUv = False

                vertMap = {}

                mesh_triangulate (me)
                me.calc_normals_split()

                me_verts = me.vertices[:]
                hasUv = len(me.uv_textures) > 0
                if hasUv:
                    uv_layer = me.uv_layers.active.data[:]
                    ngeom.hasUv = True
                loops = me.loops                
                
                # Create full vertex map
                for face in me.polygons:
                    verts = face.vertices[:]

                    # Vertices
                    for vi in verts:
                        vert = me_verts[vi]
                        ps = vert.co[:]
                        vertMap[vi] = ps

                # Create triangle data
                for face in me.polygons:
                    verts = face.vertices[:]
                    triangle = exporter.io_Triangle ()

                    # Normals
                    normals = {}                    
                    for l_idx in face.loop_indices:
                        loop = loops[l_idx]
                        vi = loop.vertex_index
                        normal = loop.normal[:]
                        normals[vi] = normal

                    # Uvs
                    uvs = {}
                    if hasUv:
                        for l_idx in face.loop_indices:
                            loop = loops[l_idx]
                            uv = uv_layer[l_idx].uv
                            vi = loop.vertex_index
                            uvs[vi] = uv[:]

                    # Vertices
                    for vi in verts:
                        vert = me_verts[vi]
                        ps = vert.co[:]
                        normal = normals[vi]

                        nvert = exporter.io_Vertex ()
                        vps = veckey3d (ps)
                        vnor = veckey3d (normal) 
                        nvert.setPosition (vps[0], vps[1], vps[2])
                        nvert.setNormal (vnor[0], vnor[1], vnor[2])
                        if hasUv:
                            uv = uvs[vi]
                            nvert.setUv (uv[0], uv[1])
                        triangle.addVertex (nvert)
                    
                    ngeom.addTriangle (triangle)

                nmodel.name = ob.name
                nmodel.geometry = ngeom
                nscene.addModel (nmodel)

        fhmd = exporter.io_Exporter ()
        fhmd.write (filepath, nscene)
    return {'FINISHED'}