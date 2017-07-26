
import os

import bpy
import mathutils
import bpy_extras.io_utils
from . import exporter

from progress_report import ProgressReport, ProgressReportSubstep

def save(context, filepath,
        EXPORT_APPLY_MODIFIERS = True):
    with ProgressReport(context.window_manager) as progress:
        scene = context.scene
        if bpy.ops.object.mode_set.poll():
            bpy.ops.object.mode_set(mode='OBJECT')
        
        frame = scene.frame_current
        scene.frame_set(frame, 0.0)
        objects = scene.objects

        for i, ob_main in enumerate(objects):
            obs = [(ob_main, ob_main.matrix_world)]

            for ob, ob_mat in obs: 
                try:
                    me = ob.to_mesh(scene, EXPORT_APPLY_MODIFIERS, 'PREVIEW', calc_tessface=False)
                except RuntimeError:
                    continue

                me_verts = me.vertices[:]
                ngeom = exporter.exporter_Mesh ()
                ngeom.addVertex (me_verts[0], me_verts[1], me_verts[2])

        fhmd = exporter.exporter_Exporter ()
        fhmd.write (filepath)
    return {'FINISHED'}