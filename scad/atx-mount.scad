include <NopSCADlib/lib.scad>
use <parts/psu-mount.scad>
include <vitamins/motherboards.scad>

motherboard_type = ATX;

show_mother_board_assembly = true;
show_psu_assembly = true;

//! TODO: Assembly instructions
module main_assembly()
assembly("main") {
    if (show_mother_board_assembly)
        motherboard(motherboard_type);
    if (show_psu_assembly)
        // translate([psu_mount_width() / 2, motherboard_mount_length() - psu_mount_length() / 2, -psu_mount_height()])
        //     rotate(-90)
        psu_assembly();
}

if($preview)
    main_assembly();
