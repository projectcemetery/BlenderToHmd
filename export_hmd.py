
import os

import bpy
import mathutils
import bpy_extras.io_utils
from . import hmd

from progress_report import ProgressReport, ProgressReportSubstep

def save(context, filepath):
    with ProgressReport(context.window_manager) as progress:
        fhmd = hmd.Hmd ()
        fhmd.write (filepath)
    return {'FINISHED'}