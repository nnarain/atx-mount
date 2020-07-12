// SSD and HDD Specifications
// Based on SFF-8301 Rev 1.9
//
// @author Natesh Narain
// @date July 11 2020
//

// 3.5" HDD Dimensions from SFF-8301 Rev 1.9
_A1 = 17.80;
_A2 = 147.00;
_A3 = 101.60;
_A4 = 95.25;
_A5 = 3.18;
_A6 = 44.45;
_A7 = 41.28;
_A8 = 28.50;
_A9 = 101.60;
_A10 = 6.35;
_A11 = 0.25;
_A12 = 0.50;
_A13 = 76.20;

HDD_3_5 = [
    // Dimensions
    [_A2, _A3, _A1],
    // Bottom mounting hole positions
    [
        [_A7, _A5], [_A7 + _A6, _A5], [_A7 + _A13, _A5],
        [_A7, _A3 - _A5], [_A7 + _A6, _A3 - _A5], [_A7 + _A13, _A3 - _A5],
    ],
    // Side mounting holes
    [
        [_A8, _A10], [_A8 + _A9, _A10]
    ],
    // Mounting screw size: 6-32
    3.51 / 2,
];

// TODO: SSD
// SSD_2_5 = [[5, 10, 3]];


use <drive.scad>
