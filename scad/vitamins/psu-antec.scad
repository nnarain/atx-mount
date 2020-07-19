// Antec PSUs
//
// @author Natesh Narain
//

include <NopSCADlib/vitamins/fans.scad>

// Antec Earthwatts Gold Pro 550 W 80+ Gold
EA550G_PRO = [
    "EA550G_PRO", "EA550G-PRO", 150, 140, 86, No632_pan_screw, 5/2, true, 0, 0, [],
    [
        // Faces
        [[], 0.8, []],
        [[], 0.8, [], false, [0, 0, fan120x25]],
        [[], 0.8, []],
        [[], 0.8, []],
        [[[-69, -27], [-69,  37], [69,  37], [45, -37]], 0.8, [], false, [], [45, -19.6, 180, IEC_inlet_atx], [23, -18, 0, small_rocker]], // TODO: Rocker switch positioning
        [[], 0.8, []],
    ],
    [": IEC mains lead"]
];
