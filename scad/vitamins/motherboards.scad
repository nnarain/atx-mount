// ATX Motherboard
// Based on "ATX Specification Version 2.2"
//
// @author Natesh Narain
// @date July 11 2020
//

ATX_POS_A = [10.16, 14.0716];
ATX_POS_C = [ATX_POS_A[0], 92.8116];
ATX_POS_F = [33.02, 296.012];
ATX_POS_G = [165.1, ATX_POS_A[1]];
ATX_POS_H = [ATX_POS_G[0], ATX_POS_C[1]];
ATX_POS_J = [ATX_POS_G[0], ATX_POS_F[1]];
ATX_POS_K = [237.49, ATX_POS_G[1]];
ATX_POS_L = [ATX_POS_K[0], ATX_POS_C[1]];
ATX_POS_M = [ATX_POS_K[0], ATX_POS_F[1]];

mounting_hole_radius = 3.96 / 2;

// Full ATX specification
ATX = [
    // Length, width, thickness
    [305, 244, 5],
    // Mounting hole positions
    [
        ATX_POS_A, ATX_POS_C, ATX_POS_F,
        ATX_POS_G, ATX_POS_H, ATX_POS_J,
        ATX_POS_K, ATX_POS_L, ATX_POS_M
    ],
    // Mounting hole radius
    mounting_hole_radius,
    // IO Shield Dimensions
    [158.75, 25.4, 20], // TODO: Check this height
];

// TODO: microATX Specification
MICROATX = [];

use <motherboard.scad>
