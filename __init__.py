import importlib

bl_info = {
    "name": "Heaps HMD format",
    "author": "Grabli66",
    "version": (0, 0, 1),
    "blender": (2, 77, 0),
    "location": "File > Import-Export",
    "description": "Export mesh, UVs, materials and animations to heaps HMD format",
    "warning": "",
    "wiki_url": "",    
    "category": "Import-Export"}

if "bpy" in locals():
    if "export_hmd" in locals():
        importlib.reload(export_hmd)


import bpy
from bpy.props import (
        BoolProperty,
        FloatProperty,
        StringProperty,
        EnumProperty,
        )
from bpy_extras.io_utils import (
        ExportHelper,
        orientation_helper_factory,
        path_reference_mode,
        axis_conversion,
        )


IOOBJOrientationHelper = orientation_helper_factory("IOOBJOrientationHelper", axis_forward='-Z', axis_up='Y')


class ExportHMD(bpy.types.Operator, ExportHelper, IOOBJOrientationHelper):
    """Save a HMD File"""

    bl_idname = "export_scene.hmd"
    bl_label = 'Export HMD'
    bl_options = {'PRESET'}

    filename_ext = ".hmd"
    filter_glob = StringProperty(
            default="*.hmd",
            options={'HIDDEN'},
            )

    # context group
    use_selection = BoolProperty(
            name="Selection Only",
            description="Export selected objects only",
            default=False,
            )
    use_animation = BoolProperty(
            name="Skeletal animation",
            description="Write baked skeletal animations",
            default=False,
            )    

    global_scale = FloatProperty(
            name="Scale",
            min=0.01, max=1000.0,
            default=1.0,
            )

    path_mode = path_reference_mode

    check_extension = True

    def execute(self, context):
        from . import export_hmd
        from mathutils import Matrix

        keywords = self.as_keywords(ignore=("axis_forward",
                                            "axis_up",
                                            "global_scale",
                                            "check_existing",
                                            "filter_glob",
                                            ))
        global_matrix = (Matrix.Scale(self.global_scale, 4) *
                         axis_conversion(to_forward=self.axis_forward,
                                         to_up=self.axis_up,
                                         ).to_4x4())

        keywords["global_matrix"] = global_matrix

        return export_hmd.save(context, keywords["filepath"])


def menu_func_export(self, context):
    self.layout.operator(ExportHMD.bl_idname, text="Heaps (.hmd)")

def register():
    bpy.utils.register_module(__name__)

    bpy.types.INFO_MT_file_export.append(menu_func_export)

def unregister():
    bpy.utils.unregister_module(__name__)
    
    bpy.types.INFO_MT_file_export.remove(menu_func_export)

if __name__ == "__main__":
    register()
