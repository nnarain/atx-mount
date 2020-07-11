// 2.5" SSD
// 3.5" HDD

SSD_2_5 = [[5, 10, 3]];
HDD_3_5 = [[5, 10, 3]];

function drive_dims(spec) spec[0];

module drive(spec) {
    cube(drive_dims(spec));
}
