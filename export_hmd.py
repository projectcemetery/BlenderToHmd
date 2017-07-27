
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
                
                mesh_triangulate (me)
                me.calc_normals_split()

                me_verts = me.vertices[:]
                loops = me.loops

                ngeom = exporter.io_Geometry ()

                for face in me.polygons:
                    triangle = exporter.io_Triangle ()
                    verts = face.vertices[:]

                    # Face vertices
                    for vi in verts:
                        vert = me_verts[vi]
                        ps = vert.co[:]
                        triangle.addVertex (ps[0], ps[1], ps[2])

                    # Face normals
                    for l_idx in face.loop_indices:
                        normal = loops[l_idx].normal

                    ngeom.addTriangle (triangle)

                nmodel.geometry = ngeom
                nscene.addModel (nmodel)

        fhmd = exporter.io_Exporter ()
        fhmd.write (filepath, nscene)
    return {'FINISHED'}