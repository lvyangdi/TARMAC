
module s1423 ( CK, G0, G1, G10, G11, G12, G13, G14, G15, G16, G2, G3, 
        G4, G5, G6, G7, G701BF, G702, G726, G727, G729, G8, G9 );
  input  CK, G0, G1, G10, G11, G12, G13, G14, G15, G16, G2, G3, G4,
         G5, G6, G7, G8, G9;
  output G701BF, G702, G726, G727, G729;
  wire   G22, G332BF, G23, G328BF, G109, G25, G113, G26, G118, G125, G28, G129,
         G140, G30, G144, G31, G149, G32, G154, G33, G159, G34, G166, G35,
         G175, G189, G37, G193, G38, G198, G39, G208, G214, G41, G218, G42,
         G237, G43, G242, G44, G247, G45, G252, G46, G260, G47, G303, G48,
         G309, G49, G315, G50, G321, G51, G360, G52, G365, G53, G373, G54,
         G379, G55, G384, G56, G392, G57, G397, G58, G405, G59, G408, G60,
         G416, G61, G424, G427, G63, G438, G64, G441, G65, G447, G66, G451,
         G67, G459, G68, G464, G69, G469, G70, G477, G71, G494, G72, G498, G73,
         G503, G74, G526, G75, G531, G76, G536, G77, G541, G78, G548, G79,
         G565, G80, G569, G81, G573, G82, G577, G83, G590, G84, G608, G85,
         G613, G86, G657, G87, G663, G88, G669, G89, G675, G90, G682, G91,
         G687, G92, G693, G93, G705, G94, G707, G95, G713, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380,
         n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402,
         n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413,
         n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446,
         n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457,
         n458, n459, n460, n461, n462, n463, n464, n465, n466, n467, n468,
         n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, n479,
         n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490,
         n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501,
         n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512,
         n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523,
         n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n534,
         n535, n536, n537, n538, n539, n540, n541, n542, n543, n544, n545,
         n546, n547, n548, n549, n550, n551, n552, n553, n554, n555, n556,
         n557, n558, n559, n560, n561, n562, n563, n564, n565, n566, n567,
         n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578,
         n579, n580, n581, n582, n583, n584, n585, n586, n587, n588, n589,
         n590, n591, n592, n593, n594, n595, n596, n597, n598, n599, n600,
         n601, n602, n603, n604, n605, n606, n607, n608, n609, n610, n611,
         n612, n613, n614, n615, n616, n617, n618, n619, n620, n621, n622,
         n623, n624, n625, n626, n627, n628, n629, n630, n631, n632, n633,
         n634, n635, n636, n637, n638, n639, n640, n641, n642, n643, n644,
         n645, n646, n647, n648, n649, n650, n651, n652, n653, n654, n655,
         n656, n657, n658, n659, n660, n661, n662, n663, n664, n665, n666,
         n667, n668, n669, n670, n671, n672, n673, n674, n675, n676, n677,
         n678, n679, n680, n681;
  assign G726 = G93;
  assign G729 = G95;

  hi1s1 U422 ( .Q(n379), .DIN(n378) );
  hi1s1 U423 ( .Q(n380), .DIN(G14) );
  nor2s1 U424 ( .Q(G727), .DIN1(G90), .DIN2(n381) );
  and4s1 U425 ( .Q(G713), .DIN1(n382), .DIN2(G83), .DIN3(n383), .DIN4(G14) );
  and2s1 U426 ( .Q(n383), .DIN1(n384), .DIN2(n385) );
  nnd2s1 U427 ( .Q(G707), .DIN1(n386), .DIN2(n387) );
  nnd2s1 U428 ( .Q(n387), .DIN1(G94), .DIN2(n388) );
  nnd2s1 U429 ( .Q(n386), .DIN1(n389), .DIN2(n360) );
  and2s1 U430 ( .Q(G705), .DIN1(G14), .DIN2(n390) );
  nnd2s1 U431 ( .Q(n390), .DIN1(n391), .DIN2(n392) );
  nnd3s1 U432 ( .Q(n392), .DIN1(n393), .DIN2(n394), .DIN3(n395) );
  nnd2s1 U433 ( .Q(n394), .DIN1(n396), .DIN2(n378) );
  nnd2s1 U434 ( .Q(n396), .DIN1(G6), .DIN2(G35) );
  nnd2s1 U435 ( .Q(n393), .DIN1(n397), .DIN2(G90) );
  nnd2s1 U436 ( .Q(n397), .DIN1(n398), .DIN2(n399) );
  nnd2s1 U437 ( .Q(n399), .DIN1(G91), .DIN2(n355) );
  or2s1 U438 ( .Q(n398), .DIN1(G59), .DIN2(G91) );
  nnd2s1 U439 ( .Q(n391), .DIN1(n400), .DIN2(n401) );
  nnd2s1 U440 ( .Q(n400), .DIN1(n402), .DIN2(n403) );
  nnd2s1 U441 ( .Q(n403), .DIN1(n404), .DIN2(n405) );
  nnd2s1 U442 ( .Q(n405), .DIN1(n382), .DIN2(n406) );
  nnd3s1 U443 ( .Q(n406), .DIN1(n407), .DIN2(n345), .DIN3(n408) );
  nnd2s1 U444 ( .Q(n402), .DIN1(n409), .DIN2(n378) );
  nnd2s1 U445 ( .Q(n409), .DIN1(n410), .DIN2(n411) );
  nnd3s1 U446 ( .Q(n411), .DIN1(n407), .DIN2(n412), .DIN3(n413) );
  hi1s1 U447 ( .Q(n412), .DIN(G5) );
  nnd4s1 U448 ( .Q(n407), .DIN1(n414), .DIN2(n415), .DIN3(n416), .DIN4(n417)
         );
  and2s1 U449 ( .Q(n416), .DIN1(n418), .DIN2(n419) );
  nnd2s1 U450 ( .Q(n410), .DIN1(n420), .DIN2(n413) );
  hi1s1 U451 ( .Q(n413), .DIN(G6) );
  and4s1 U452 ( .Q(G702), .DIN1(n421), .DIN2(n422), .DIN3(n423), .DIN4(n424)
         );
  nnd3s1 U453 ( .Q(n424), .DIN1(G41), .DIN2(n425), .DIN3(G88) );
  nor2s1 U454 ( .Q(n423), .DIN1(G90), .DIN2(n426) );
  nor2s1 U455 ( .Q(n426), .DIN1(n427), .DIN2(n360) );
  nnd3s1 U456 ( .Q(n422), .DIN1(n428), .DIN2(n363), .DIN3(G28) );
  nnd2s1 U457 ( .Q(n421), .DIN1(G87), .DIN2(n429) );
  nnd3s1 U458 ( .Q(G693), .DIN1(n430), .DIN2(n431), .DIN3(G657) );
  nnd3s1 U459 ( .Q(n431), .DIN1(G92), .DIN2(n432), .DIN3(G86) );
  nnd2s1 U460 ( .Q(n430), .DIN1(n433), .DIN2(G91) );
  nnd3s1 U461 ( .Q(G687), .DIN1(n434), .DIN2(n435), .DIN3(G657) );
  nnd3s1 U462 ( .Q(n435), .DIN1(G91), .DIN2(n432), .DIN3(G86) );
  hi1s1 U463 ( .Q(n432), .DIN(G10) );
  nnd2s1 U464 ( .Q(n434), .DIN1(n433), .DIN2(n379) );
  hi1s1 U465 ( .Q(n433), .DIN(n436) );
  nnd3s1 U466 ( .Q(G682), .DIN1(n437), .DIN2(n436), .DIN3(G657) );
  nnd2s1 U467 ( .Q(n436), .DIN1(G10), .DIN2(G86) );
  nnd2s1 U468 ( .Q(n437), .DIN1(G86), .DIN2(G90) );
  nnd2s1 U469 ( .Q(G675), .DIN1(n438), .DIN2(n439) );
  nnd2s1 U470 ( .Q(n439), .DIN1(G89), .DIN2(n388) );
  nnd2s1 U471 ( .Q(n438), .DIN1(G88), .DIN2(n389) );
  nnd2s1 U472 ( .Q(G669), .DIN1(n440), .DIN2(n441) );
  nnd2s1 U473 ( .Q(n441), .DIN1(G88), .DIN2(n388) );
  nnd2s1 U474 ( .Q(n440), .DIN1(G87), .DIN2(n389) );
  nnd2s1 U475 ( .Q(G663), .DIN1(n442), .DIN2(n443) );
  nnd2s1 U476 ( .Q(n443), .DIN1(G87), .DIN2(n388) );
  nor2s1 U477 ( .Q(n388), .DIN1(n380), .DIN2(G11) );
  nnd2s1 U478 ( .Q(n442), .DIN1(n389), .DIN2(n363) );
  and2s1 U479 ( .Q(n389), .DIN1(G11), .DIN2(G14) );
  and2s1 U480 ( .Q(G657), .DIN1(G13), .DIN2(G14) );
  nnd2s1 U481 ( .Q(G613), .DIN1(n445), .DIN2(n446) );
  nnd2s1 U482 ( .Q(n446), .DIN1(G11), .DIN2(n447) );
  nnd2s1 U483 ( .Q(n445), .DIN1(G85), .DIN2(n448) );
  nnd2s1 U484 ( .Q(G608), .DIN1(n449), .DIN2(n450) );
  nnd2s1 U485 ( .Q(n450), .DIN1(G10), .DIN2(n447) );
  nnd2s1 U486 ( .Q(n449), .DIN1(G84), .DIN2(n448) );
  nor2s1 U487 ( .Q(G590), .DIN1(n451), .DIN2(n452) );
  nor2s1 U488 ( .Q(n451), .DIN1(n453), .DIN2(n454) );
  nor2s1 U489 ( .Q(n453), .DIN1(n455), .DIN2(n345) );
  nor2s1 U490 ( .Q(n455), .DIN1(n382), .DIN2(n456) );
  nnd2s1 U491 ( .Q(G577), .DIN1(n457), .DIN2(n458) );
  nnd2s1 U492 ( .Q(n458), .DIN1(G9), .DIN2(n447) );
  nnd2s1 U493 ( .Q(n457), .DIN1(G82), .DIN2(n448) );
  nnd2s1 U494 ( .Q(G573), .DIN1(n459), .DIN2(n460) );
  nnd2s1 U495 ( .Q(n460), .DIN1(G8), .DIN2(n447) );
  nnd2s1 U496 ( .Q(n459), .DIN1(G81), .DIN2(n448) );
  nnd2s1 U497 ( .Q(G569), .DIN1(n461), .DIN2(n462) );
  nnd2s1 U498 ( .Q(n462), .DIN1(G7), .DIN2(n447) );
  nnd2s1 U499 ( .Q(n461), .DIN1(G80), .DIN2(n448) );
  nnd2s1 U500 ( .Q(G565), .DIN1(n463), .DIN2(n464) );
  nnd2s1 U501 ( .Q(n464), .DIN1(G6), .DIN2(n447) );
  nnd2s1 U502 ( .Q(n463), .DIN1(G79), .DIN2(n448) );
  hi1s1 U503 ( .Q(n448), .DIN(n447) );
  nnd2s1 U504 ( .Q(n447), .DIN1(G14), .DIN2(n465) );
  nnd2s1 U505 ( .Q(n465), .DIN1(G91), .DIN2(n466) );
  nor2s1 U506 ( .Q(G548), .DIN1(n467), .DIN2(n452) );
  xor2s1 U507 ( .Q(n467), .DIN1(G78), .DIN2(n468) );
  and3s1 U508 ( .Q(G541), .DIN1(n469), .DIN2(n468), .DIN3(n470) );
  nnd3s1 U509 ( .Q(n468), .DIN1(G77), .DIN2(G76), .DIN3(n471) );
  nnd2s1 U510 ( .Q(n469), .DIN1(n369), .DIN2(n472) );
  nnd2s1 U511 ( .Q(n472), .DIN1(n471), .DIN2(G76) );
  hi1s1 U512 ( .Q(n471), .DIN(n473) );
  nor2s1 U513 ( .Q(G536), .DIN1(n474), .DIN2(n452) );
  xor2s1 U514 ( .Q(n474), .DIN1(G76), .DIN2(n473) );
  and3s1 U515 ( .Q(G531), .DIN1(n475), .DIN2(n473), .DIN3(n470) );
  hi1s1 U516 ( .Q(n470), .DIN(n452) );
  nnd3s1 U517 ( .Q(n473), .DIN1(G74), .DIN2(G75), .DIN3(n454) );
  nnd2s1 U518 ( .Q(n475), .DIN1(n356), .DIN2(n476) );
  nnd2s1 U519 ( .Q(n476), .DIN1(n454), .DIN2(G74) );
  nor2s1 U520 ( .Q(G526), .DIN1(n477), .DIN2(n452) );
  nnd2s1 U521 ( .Q(n452), .DIN1(n478), .DIN2(n479) );
  nnd2s1 U522 ( .Q(n479), .DIN1(G9), .DIN2(n378) );
  xor2s1 U523 ( .Q(n477), .DIN1(n346), .DIN2(n454) );
  and3s1 U524 ( .Q(n454), .DIN1(n480), .DIN2(n481), .DIN3(n456) );
  nnd2s1 U525 ( .Q(n481), .DIN1(n404), .DIN2(n482) );
  nnd2s1 U526 ( .Q(n482), .DIN1(n483), .DIN2(n364) );
  nnd3s1 U527 ( .Q(n480), .DIN1(G92), .DIN2(n484), .DIN3(n395) );
  nnd2s1 U528 ( .Q(n484), .DIN1(n485), .DIN2(G34) );
  nnd2s1 U529 ( .Q(G503), .DIN1(n486), .DIN2(n487) );
  nnd2s1 U530 ( .Q(n487), .DIN1(n488), .DIN2(n489) );
  nnd2s1 U531 ( .Q(n488), .DIN1(n490), .DIN2(n491) );
  nnd2s1 U532 ( .Q(n491), .DIN1(G2), .DIN2(n350) );
  nnd2s1 U533 ( .Q(n490), .DIN1(G5), .DIN2(G63) );
  nnd2s1 U534 ( .Q(n486), .DIN1(G73), .DIN2(n492) );
  nnd2s1 U535 ( .Q(G498), .DIN1(n493), .DIN2(n494) );
  nnd2s1 U536 ( .Q(n494), .DIN1(n495), .DIN2(n489) );
  nnd2s1 U537 ( .Q(n495), .DIN1(n496), .DIN2(n497) );
  nnd2s1 U538 ( .Q(n497), .DIN1(G1), .DIN2(n350) );
  nnd2s1 U539 ( .Q(n496), .DIN1(G4), .DIN2(G63) );
  nnd2s1 U540 ( .Q(n493), .DIN1(G72), .DIN2(n492) );
  nnd2s1 U541 ( .Q(G494), .DIN1(n498), .DIN2(n499) );
  nnd2s1 U542 ( .Q(n499), .DIN1(n500), .DIN2(n489) );
  nnd2s1 U543 ( .Q(n500), .DIN1(n501), .DIN2(n502) );
  nnd2s1 U544 ( .Q(n502), .DIN1(G0), .DIN2(n350) );
  nnd2s1 U545 ( .Q(n501), .DIN1(G3), .DIN2(G63) );
  nnd2s1 U546 ( .Q(n498), .DIN1(G71), .DIN2(n492) );
  hi1s1 U547 ( .Q(n492), .DIN(n489) );
  nnd2s1 U548 ( .Q(n489), .DIN1(G14), .DIN2(n478) );
  and3s1 U549 ( .Q(G477), .DIN1(n503), .DIN2(n504), .DIN3(n381) );
  nnd2s1 U550 ( .Q(n504), .DIN1(n505), .DIN2(n372) );
  nnd2s1 U551 ( .Q(n505), .DIN1(n506), .DIN2(G69) );
  nnd3s1 U552 ( .Q(n503), .DIN1(n506), .DIN2(G69), .DIN3(G70) );
  nor2s1 U553 ( .Q(G469), .DIN1(n507), .DIN2(n466) );
  xor2s1 U554 ( .Q(n507), .DIN1(n351), .DIN2(n506) );
  hi1s1 U555 ( .Q(n506), .DIN(n508) );
  and3s1 U556 ( .Q(G464), .DIN1(n509), .DIN2(n508), .DIN3(n381) );
  nnd3s1 U557 ( .Q(n508), .DIN1(G67), .DIN2(n510), .DIN3(G68) );
  nnd2s1 U558 ( .Q(n509), .DIN1(n358), .DIN2(n511) );
  nnd2s1 U559 ( .Q(n511), .DIN1(G67), .DIN2(n510) );
  nor2s1 U560 ( .Q(G459), .DIN1(n466), .DIN2(n512) );
  xor2s1 U561 ( .Q(n512), .DIN1(n510), .DIN2(n352) );
  nnd2s1 U562 ( .Q(n510), .DIN1(G90), .DIN2(n513) );
  nnd2s1 U563 ( .Q(n513), .DIN1(n514), .DIN2(n515) );
  nnd2s1 U564 ( .Q(n515), .DIN1(G91), .DIN2(n427) );
  nnd2s1 U565 ( .Q(G451), .DIN1(n516), .DIN2(n517) );
  nnd2s1 U566 ( .Q(n517), .DIN1(G65), .DIN2(n518) );
  nnd2s1 U567 ( .Q(n516), .DIN1(G66), .DIN2(n381) );
  nnd2s1 U568 ( .Q(G447), .DIN1(n519), .DIN2(n520) );
  nnd2s1 U569 ( .Q(n520), .DIN1(G65), .DIN2(G14) );
  hi1s1 U570 ( .Q(n519), .DIN(n518) );
  nnd2s1 U571 ( .Q(G441), .DIN1(n521), .DIN2(n522) );
  nnd2s1 U572 ( .Q(n522), .DIN1(n518), .DIN2(G63) );
  nor2s1 U573 ( .Q(n518), .DIN1(n523), .DIN2(n444) );
  nnd2s1 U574 ( .Q(n521), .DIN1(n381), .DIN2(G64) );
  hi1s1 U575 ( .Q(n381), .DIN(n466) );
  nor2s1 U576 ( .Q(G438), .DIN1(n524), .DIN2(n444) );
  nor2s1 U577 ( .Q(n524), .DIN1(G63), .DIN2(n382) );
  hi1s1 U578 ( .Q(n382), .DIN(n420) );
  nnd2s1 U579 ( .Q(n420), .DIN1(n525), .DIN2(n526) );
  nnd2s1 U580 ( .Q(n526), .DIN1(n404), .DIN2(n364) );
  nnd2s1 U581 ( .Q(n525), .DIN1(n527), .DIN2(n395) );
  nnd2s1 U582 ( .Q(n527), .DIN1(n528), .DIN2(n529) );
  or2s1 U583 ( .Q(n529), .DIN1(G35), .DIN2(G92) );
  nnd2s1 U584 ( .Q(n528), .DIN1(G92), .DIN2(G34) );
  and3s1 U585 ( .Q(G427), .DIN1(n530), .DIN2(n427), .DIN3(G14) );
  or2s1 U586 ( .Q(n427), .DIN1(n355), .DIN2(n531) );
  nnd2s1 U587 ( .Q(n530), .DIN1(n355), .DIN2(n531) );
  nor2s1 U588 ( .Q(G424), .DIN1(n532), .DIN2(n533) );
  nor2s1 U589 ( .Q(n532), .DIN1(n534), .DIN2(G61) );
  and2s1 U590 ( .Q(n534), .DIN1(n535), .DIN2(G60) );
  nor2s1 U591 ( .Q(G416), .DIN1(n536), .DIN2(n533) );
  nnd2s1 U592 ( .Q(n533), .DIN1(G14), .DIN2(n531) );
  nnd2s1 U593 ( .Q(n531), .DIN1(G61), .DIN2(n535) );
  xor2s1 U594 ( .Q(n536), .DIN1(G60), .DIN2(n537) );
  and3s1 U595 ( .Q(G408), .DIN1(n538), .DIN2(n539), .DIN3(G14) );
  nnd2s1 U596 ( .Q(n538), .DIN1(n361), .DIN2(n540) );
  nor2s1 U597 ( .Q(G405), .DIN1(n541), .DIN2(n542) );
  nor2s1 U598 ( .Q(n541), .DIN1(n543), .DIN2(G58) );
  and2s1 U599 ( .Q(n543), .DIN1(n544), .DIN2(G57) );
  nor2s1 U600 ( .Q(G397), .DIN1(n545), .DIN2(n542) );
  nnd2s1 U601 ( .Q(n542), .DIN1(G14), .DIN2(n540) );
  xor2s1 U602 ( .Q(n545), .DIN1(n546), .DIN2(G57) );
  hi1s1 U603 ( .Q(n546), .DIN(n544) );
  nor2s1 U604 ( .Q(G392), .DIN1(n547), .DIN2(n548) );
  nor2s1 U605 ( .Q(n547), .DIN1(n549), .DIN2(G56) );
  nor3s1 U606 ( .Q(G384), .DIN1(n550), .DIN2(n549), .DIN3(n548) );
  and2s1 U607 ( .Q(n549), .DIN1(G55), .DIN2(n551) );
  nor2s1 U608 ( .Q(n550), .DIN1(G55), .DIN2(n551) );
  nor2s1 U609 ( .Q(G379), .DIN1(n548), .DIN2(n552) );
  xor2s1 U610 ( .Q(n552), .DIN1(n553), .DIN2(G54) );
  nnd2s1 U611 ( .Q(n548), .DIN1(G14), .DIN2(n554) );
  nor2s1 U612 ( .Q(G373), .DIN1(n555), .DIN2(n556) );
  hi1s1 U613 ( .Q(n556), .DIN(n557) );
  nor2s1 U614 ( .Q(n555), .DIN1(n558), .DIN2(G53) );
  hi1s1 U615 ( .Q(n558), .DIN(n559) );
  and3s1 U616 ( .Q(G365), .DIN1(n560), .DIN2(n559), .DIN3(n557) );
  nnd3s1 U617 ( .Q(n559), .DIN1(G51), .DIN2(n561), .DIN3(G52) );
  nnd2s1 U618 ( .Q(n560), .DIN1(n373), .DIN2(n562) );
  nnd2s1 U619 ( .Q(n562), .DIN1(G51), .DIN2(n561) );
  and2s1 U620 ( .Q(G360), .DIN1(n557), .DIN2(n563) );
  xor2s1 U621 ( .Q(n563), .DIN1(G51), .DIN2(n561) );
  nor2s1 U622 ( .Q(n557), .DIN1(n444), .DIN2(n535) );
  hi1s1 U623 ( .Q(n535), .DIN(n537) );
  nnd2s1 U624 ( .Q(n537), .DIN1(G53), .DIN2(n561) );
  nnd2s1 U625 ( .Q(n561), .DIN1(G91), .DIN2(n539) );
  hi1s1 U626 ( .Q(n539), .DIN(n514) );
  nor2s1 U627 ( .Q(n514), .DIN1(n361), .DIN2(n540) );
  nnd2s1 U628 ( .Q(n540), .DIN1(G58), .DIN2(n544) );
  nnd2s1 U629 ( .Q(n544), .DIN1(n564), .DIN2(n565) );
  nnd2s1 U630 ( .Q(n565), .DIN1(n566), .DIN2(n395) );
  nnd3s1 U631 ( .Q(n564), .DIN1(G38), .DIN2(n483), .DIN3(n404) );
  hi1s1 U632 ( .Q(n404), .DIN(n395) );
  nnd2s1 U633 ( .Q(n395), .DIN1(G90), .DIN2(n567) );
  nnd4s1 U634 ( .Q(n567), .DIN1(G16), .DIN2(n408), .DIN3(n366), .DIN4(n345) );
  hi1s1 U635 ( .Q(n408), .DIN(n456) );
  nnd4s1 U636 ( .Q(n456), .DIN1(n568), .DIN2(n569), .DIN3(n570), .DIN4(n571)
         );
  nor2s1 U637 ( .Q(n571), .DIN1(n572), .DIN2(n573) );
  xor2s1 U638 ( .Q(n573), .DIN1(G82), .DIN2(G77) );
  xor2s1 U639 ( .Q(n572), .DIN1(G81), .DIN2(G76) );
  xor2s1 U640 ( .Q(n570), .DIN1(n346), .DIN2(G79) );
  xor2s1 U641 ( .Q(n569), .DIN1(n356), .DIN2(G80) );
  xor2s1 U642 ( .Q(n568), .DIN1(G78), .DIN2(n574) );
  or4s1 U643 ( .Q(n574), .DIN1(G79), .DIN2(G80), .DIN3(G81), .DIN4(G82) );
  hi1s1 U644 ( .Q(n483), .DIN(n575) );
  nnd2s1 U645 ( .Q(G321), .DIN1(n576), .DIN2(n577) );
  nnd2s1 U646 ( .Q(n577), .DIN1(n578), .DIN2(G50) );
  nnd2s1 U647 ( .Q(n576), .DIN1(n579), .DIN2(G49) );
  nnd2s1 U648 ( .Q(G315), .DIN1(n580), .DIN2(n581) );
  nnd2s1 U649 ( .Q(n581), .DIN1(n578), .DIN2(G49) );
  nnd2s1 U650 ( .Q(n580), .DIN1(n579), .DIN2(G48) );
  nnd2s1 U651 ( .Q(G309), .DIN1(n582), .DIN2(n583) );
  nnd2s1 U652 ( .Q(n583), .DIN1(n578), .DIN2(G48) );
  nnd2s1 U653 ( .Q(n582), .DIN1(n579), .DIN2(G47) );
  nnd2s1 U654 ( .Q(G303), .DIN1(n584), .DIN2(n585) );
  nnd2s1 U655 ( .Q(n585), .DIN1(n578), .DIN2(G47) );
  nor2s1 U656 ( .Q(n578), .DIN1(n586), .DIN2(n444) );
  nnd2s1 U657 ( .Q(n584), .DIN1(G12), .DIN2(n579) );
  and2s1 U658 ( .Q(n579), .DIN1(G14), .DIN2(n586) );
  nnd2s1 U659 ( .Q(n586), .DIN1(G91), .DIN2(n554) );
  nnd2s1 U660 ( .Q(n554), .DIN1(G56), .DIN2(n551) );
  and2s1 U661 ( .Q(n551), .DIN1(G54), .DIN2(n566) );
  nor2s1 U662 ( .Q(G260), .DIN1(n587), .DIN2(n588) );
  xor2s1 U663 ( .Q(n587), .DIN1(G46), .DIN2(n589) );
  and3s1 U664 ( .Q(G252), .DIN1(n590), .DIN2(n589), .DIN3(n591) );
  nnd3s1 U665 ( .Q(n589), .DIN1(G44), .DIN2(G45), .DIN3(n592) );
  nnd2s1 U666 ( .Q(n590), .DIN1(n354), .DIN2(n593) );
  nnd2s1 U667 ( .Q(n593), .DIN1(n592), .DIN2(G44) );
  hi1s1 U668 ( .Q(n592), .DIN(n594) );
  nor2s1 U669 ( .Q(G247), .DIN1(n595), .DIN2(n588) );
  xor2s1 U670 ( .Q(n595), .DIN1(G44), .DIN2(n594) );
  and3s1 U671 ( .Q(G242), .DIN1(n596), .DIN2(n594), .DIN3(n591) );
  nnd3s1 U672 ( .Q(n594), .DIN1(G42), .DIN2(G43), .DIN3(n597) );
  nnd2s1 U673 ( .Q(n596), .DIN1(n353), .DIN2(n598) );
  nnd2s1 U674 ( .Q(n598), .DIN1(n597), .DIN2(G42) );
  and2s1 U675 ( .Q(G237), .DIN1(n599), .DIN2(n591) );
  hi1s1 U676 ( .Q(n591), .DIN(n588) );
  nnd2s1 U677 ( .Q(n588), .DIN1(n478), .DIN2(n600) );
  nnd2s1 U678 ( .Q(n600), .DIN1(G7), .DIN2(n378) );
  nnd2s1 U679 ( .Q(n478), .DIN1(G90), .DIN2(n466) );
  nnd2s1 U680 ( .Q(n466), .DIN1(G14), .DIN2(n523) );
  nnd4s1 U681 ( .Q(n523), .DIN1(n601), .DIN2(n602), .DIN3(n603), .DIN4(n604)
         );
  xor2s1 U682 ( .Q(n604), .DIN1(G70), .DIN2(n605) );
  or3s1 U683 ( .Q(n605), .DIN1(G72), .DIN2(G73), .DIN3(G71) );
  xor2s1 U684 ( .Q(n603), .DIN1(n352), .DIN2(G71) );
  xor2s1 U685 ( .Q(n602), .DIN1(G72), .DIN2(n358) );
  xor2s1 U686 ( .Q(n601), .DIN1(n351), .DIN2(G73) );
  xor2s1 U687 ( .Q(n599), .DIN1(n597), .DIN2(G42) );
  nor2s1 U688 ( .Q(n597), .DIN1(n606), .DIN2(G328BF) );
  nnd2s1 U689 ( .Q(G328BF), .DIN1(n607), .DIN2(n608) );
  nnd2s1 U690 ( .Q(n608), .DIN1(G23), .DIN2(G701BF) );
  hi1s1 U691 ( .Q(G701BF), .DIN(G15) );
  nnd2s1 U692 ( .Q(n607), .DIN1(G332BF), .DIN2(G15) );
  nnd2s1 U693 ( .Q(G332BF), .DIN1(n609), .DIN2(n610) );
  or2s1 U694 ( .Q(n610), .DIN1(n606), .DIN2(G15) );
  nnd2s1 U695 ( .Q(n609), .DIN1(G22), .DIN2(n611) );
  or4s1 U696 ( .Q(n611), .DIN1(G49), .DIN2(G50), .DIN3(G48), .DIN4(n612) );
  or2s1 U697 ( .Q(n612), .DIN1(G47), .DIN2(G15) );
  nnd4s1 U698 ( .Q(n606), .DIN1(G50), .DIN2(G49), .DIN3(G48), .DIN4(G47) );
  and2s1 U699 ( .Q(G218), .DIN1(n613), .DIN2(G14) );
  xor2s1 U700 ( .Q(n613), .DIN1(n425), .DIN2(G41) );
  nor2s1 U701 ( .Q(G214), .DIN1(n614), .DIN2(n444) );
  nor2s1 U702 ( .Q(n614), .DIN1(n615), .DIN2(n425) );
  nor2s1 U703 ( .Q(n615), .DIN1(n616), .DIN2(n365) );
  nor2s1 U704 ( .Q(G208), .DIN1(n617), .DIN2(n444) );
  nor2s1 U705 ( .Q(n617), .DIN1(n618), .DIN2(n616) );
  and2s1 U706 ( .Q(n618), .DIN1(n553), .DIN2(G39) );
  nor2s1 U707 ( .Q(G198), .DIN1(n619), .DIN2(n444) );
  xor2s1 U708 ( .Q(n619), .DIN1(G38), .DIN2(n575) );
  and3s1 U709 ( .Q(G193), .DIN1(n620), .DIN2(n575), .DIN3(G14) );
  nnd3s1 U710 ( .Q(n575), .DIN1(n621), .DIN2(n348), .DIN3(G37) );
  nnd2s1 U711 ( .Q(n620), .DIN1(n374), .DIN2(n622) );
  nnd2s1 U712 ( .Q(n622), .DIN1(n621), .DIN2(n348) );
  nor2s1 U713 ( .Q(G189), .DIN1(n380), .DIN2(n623) );
  xor2s1 U714 ( .Q(n623), .DIN1(n621), .DIN2(n348) );
  nnd2s1 U715 ( .Q(n621), .DIN1(G91), .DIN2(n624) );
  nnd2s1 U716 ( .Q(n624), .DIN1(G41), .DIN2(n425) );
  and2s1 U717 ( .Q(n425), .DIN1(n616), .DIN2(n365) );
  nor2s1 U718 ( .Q(n616), .DIN1(G39), .DIN2(n553) );
  hi1s1 U719 ( .Q(n553), .DIN(n566) );
  nnd2s1 U720 ( .Q(n566), .DIN1(G92), .DIN2(n625) );
  nor2s1 U721 ( .Q(G175), .DIN1(G35), .DIN2(n444) );
  nor2s1 U722 ( .Q(G166), .DIN1(n626), .DIN2(n444) );
  nor2s1 U723 ( .Q(n626), .DIN1(n627), .DIN2(n429) );
  hi1s1 U724 ( .Q(n429), .DIN(n625) );
  nnd2s1 U725 ( .Q(n625), .DIN1(n485), .DIN2(n359) );
  nor2s1 U726 ( .Q(n627), .DIN1(n485), .DIN2(n359) );
  nor2s1 U727 ( .Q(n485), .DIN1(n367), .DIN2(n628) );
  nor2s1 U728 ( .Q(G159), .DIN1(n629), .DIN2(n444) );
  xor2s1 U729 ( .Q(n629), .DIN1(G33), .DIN2(n628) );
  and3s1 U730 ( .Q(G154), .DIN1(n630), .DIN2(n628), .DIN3(G14) );
  nnd3s1 U731 ( .Q(n628), .DIN1(G31), .DIN2(n631), .DIN3(G32) );
  nnd2s1 U732 ( .Q(n630), .DIN1(n375), .DIN2(n632) );
  nnd2s1 U733 ( .Q(n632), .DIN1(G31), .DIN2(n631) );
  hi1s1 U734 ( .Q(n631), .DIN(n633) );
  nor2s1 U735 ( .Q(G149), .DIN1(n634), .DIN2(n444) );
  xor2s1 U736 ( .Q(n634), .DIN1(G31), .DIN2(n633) );
  and3s1 U737 ( .Q(G144), .DIN1(n635), .DIN2(n633), .DIN3(G14) );
  nnd3s1 U738 ( .Q(n633), .DIN1(n636), .DIN2(n347), .DIN3(G30) );
  nnd2s1 U739 ( .Q(n635), .DIN1(n376), .DIN2(n637) );
  nnd2s1 U740 ( .Q(n637), .DIN1(n636), .DIN2(n347) );
  nor2s1 U741 ( .Q(G140), .DIN1(n380), .DIN2(n638) );
  xor2s1 U742 ( .Q(n638), .DIN1(n347), .DIN2(n636) );
  nnd2s1 U743 ( .Q(n636), .DIN1(G92), .DIN2(n639) );
  nnd2s1 U744 ( .Q(n639), .DIN1(G28), .DIN2(n428) );
  nor2s1 U745 ( .Q(G129), .DIN1(n640), .DIN2(n444) );
  xor2s1 U746 ( .Q(n640), .DIN1(G28), .DIN2(n641) );
  nor2s1 U747 ( .Q(G125), .DIN1(n642), .DIN2(n444) );
  nor2s1 U748 ( .Q(n642), .DIN1(n643), .DIN2(n428) );
  hi1s1 U749 ( .Q(n428), .DIN(n641) );
  nnd2s1 U750 ( .Q(n641), .DIN1(n644), .DIN2(n362) );
  nor2s1 U751 ( .Q(n643), .DIN1(n644), .DIN2(n362) );
  nor2s1 U752 ( .Q(n644), .DIN1(n368), .DIN2(n645) );
  nor2s1 U753 ( .Q(G118), .DIN1(n646), .DIN2(n444) );
  xor2s1 U754 ( .Q(n646), .DIN1(G26), .DIN2(n645) );
  and3s1 U755 ( .Q(G113), .DIN1(n647), .DIN2(n645), .DIN3(G14) );
  nnd3s1 U756 ( .Q(n645), .DIN1(n401), .DIN2(n349), .DIN3(G25) );
  nnd2s1 U757 ( .Q(n647), .DIN1(n377), .DIN2(n648) );
  nnd2s1 U758 ( .Q(n648), .DIN1(n401), .DIN2(n349) );
  nor2s1 U759 ( .Q(G109), .DIN1(n444), .DIN2(n649) );
  xor2s1 U760 ( .Q(n649), .DIN1(n401), .DIN2(n349) );
  nnd2s1 U761 ( .Q(n401), .DIN1(n650), .DIN2(n651) );
  nnd2s1 U762 ( .Q(n651), .DIN1(n652), .DIN2(n357) );
  nnd2s1 U763 ( .Q(n650), .DIN1(n414), .DIN2(n653) );
  nnd3s1 U764 ( .Q(n653), .DIN1(n654), .DIN2(n655), .DIN3(n419) );
  nnd2s1 U765 ( .Q(n419), .DIN1(n354), .DIN2(n656) );
  nnd2s1 U766 ( .Q(n654), .DIN1(n415), .DIN2(n657) );
  nnd3s1 U767 ( .Q(n657), .DIN1(G42), .DIN2(n418), .DIN3(n658) );
  hi1s1 U768 ( .Q(n658), .DIN(n417) );
  xor2s1 U769 ( .Q(n417), .DIN1(n659), .DIN2(G42) );
  nor2s1 U770 ( .Q(n659), .DIN1(n660), .DIN2(n661) );
  nor2s1 U771 ( .Q(n661), .DIN1(G0), .DIN2(G90) );
  nor2s1 U772 ( .Q(n660), .DIN1(n346), .DIN2(n662) );
  nnd2s1 U773 ( .Q(n418), .DIN1(n353), .DIN2(n663) );
  and3s1 U774 ( .Q(n415), .DIN1(n664), .DIN2(n655), .DIN3(n665) );
  nnd2s1 U775 ( .Q(n665), .DIN1(G44), .DIN2(n666) );
  or2s1 U776 ( .Q(n655), .DIN1(G44), .DIN2(n666) );
  and2s1 U777 ( .Q(n666), .DIN1(n667), .DIN2(n668) );
  nnd2s1 U778 ( .Q(n668), .DIN1(n669), .DIN2(G76) );
  or2s1 U779 ( .Q(n667), .DIN1(G2), .DIN2(n379) );
  or2s1 U780 ( .Q(n664), .DIN1(n353), .DIN2(n663) );
  nnd2s1 U781 ( .Q(n663), .DIN1(n670), .DIN2(n671) );
  nnd2s1 U782 ( .Q(n671), .DIN1(n669), .DIN2(G75) );
  or2s1 U783 ( .Q(n670), .DIN1(G1), .DIN2(n379) );
  and2s1 U784 ( .Q(n414), .DIN1(n672), .DIN2(n673) );
  or2s1 U785 ( .Q(n673), .DIN1(n354), .DIN2(n656) );
  nnd2s1 U786 ( .Q(n656), .DIN1(n674), .DIN2(n675) );
  nnd2s1 U787 ( .Q(n675), .DIN1(n669), .DIN2(G77) );
  or2s1 U788 ( .Q(n674), .DIN1(G3), .DIN2(n379) );
  xor2s1 U789 ( .Q(n672), .DIN1(n357), .DIN2(n652) );
  nnd2s1 U790 ( .Q(n652), .DIN1(n676), .DIN2(n677) );
  nnd2s1 U791 ( .Q(n677), .DIN1(n669), .DIN2(G78) );
  hi1s1 U792 ( .Q(n669), .DIN(n662) );
  nnd3s1 U793 ( .Q(n662), .DIN1(n385), .DIN2(n384), .DIN3(G90) );
  nnd3s1 U794 ( .Q(n384), .DIN1(n678), .DIN2(n679), .DIN3(n370) );
  nnd2s1 U795 ( .Q(n679), .DIN1(G8), .DIN2(n378) );
  or2s1 U796 ( .Q(n678), .DIN1(n378), .DIN2(G64) );
  nnd3s1 U797 ( .Q(n385), .DIN1(n680), .DIN2(n681), .DIN3(n371) );
  or2s1 U798 ( .Q(n681), .DIN1(G8), .DIN2(n379) );
  nnd2s1 U799 ( .Q(n680), .DIN1(G64), .DIN2(n379) );
  or2s1 U800 ( .Q(n676), .DIN1(G4), .DIN2(n379) );
  hi1s1 U801 ( .Q(n444), .DIN(G14) );
  dffs1 \DFF_73/Q_reg  ( .Q(G95), .CLK(CK), .DIN(G713) );
  dffs1 \DFF_72/Q_reg  ( .QN(n363), .Q(G94), .CLK(CK), .DIN(G707) );
  dffs1 \DFF_71/Q_reg  ( .Q(G93), .CLK(CK), .DIN(G705) );
  dffs1 \DFF_70/Q_reg  ( .Q(G92), .CLK(CK), .DIN(G693) );
  dffs1 \DFF_69/Q_reg  ( .Q(G91), .CLK(CK), .DIN(G687) );
  dffs1 \DFF_68/Q_reg  ( .QN(n378), .Q(G90), .CLK(CK), .DIN(G682) );
  dffs1 \DFF_67/Q_reg  ( .QN(n360), .Q(G89), .CLK(CK), .DIN(G675) );
  dffs1 \DFF_66/Q_reg  ( .Q(G88), .CLK(CK), .DIN(G669) );
  dffs1 \DFF_65/Q_reg  ( .Q(G87), .CLK(CK), .DIN(G663) );
  dffs1 \DFF_64/Q_reg  ( .Q(G86), .CLK(CK), .DIN(G657) );
  dffs1 \DFF_63/Q_reg  ( .QN(n370), .Q(G85), .CLK(CK), .DIN(G613) );
  dffs1 \DFF_62/Q_reg  ( .QN(n371), .Q(G84), .CLK(CK), .DIN(G608) );
  dffs1 \DFF_61/Q_reg  ( .QN(n345), .Q(G83), .CLK(CK), .DIN(G590) );
  dffs1 \DFF_60/Q_reg  ( .Q(G82), .CLK(CK), .DIN(G577) );
  dffs1 \DFF_59/Q_reg  ( .Q(G81), .CLK(CK), .DIN(G573) );
  dffs1 \DFF_58/Q_reg  ( .Q(G80), .CLK(CK), .DIN(G569) );
  dffs1 \DFF_57/Q_reg  ( .Q(G79), .CLK(CK), .DIN(G565) );
  dffs1 \DFF_56/Q_reg  ( .Q(G78), .CLK(CK), .DIN(G548) );
  dffs1 \DFF_55/Q_reg  ( .QN(n369), .Q(G77), .CLK(CK), .DIN(G541) );
  dffs1 \DFF_54/Q_reg  ( .Q(G76), .CLK(CK), .DIN(G536) );
  dffs1 \DFF_53/Q_reg  ( .QN(n356), .Q(G75), .CLK(CK), .DIN(G531) );
  dffs1 \DFF_52/Q_reg  ( .QN(n346), .Q(G74), .CLK(CK), .DIN(G526) );
  dffs1 \DFF_51/Q_reg  ( .Q(G73), .CLK(CK), .DIN(G503) );
  dffs1 \DFF_50/Q_reg  ( .Q(G72), .CLK(CK), .DIN(G498) );
  dffs1 \DFF_49/Q_reg  ( .Q(G71), .CLK(CK), .DIN(G494) );
  dffs1 \DFF_48/Q_reg  ( .QN(n372), .Q(G70), .CLK(CK), .DIN(G477) );
  dffs1 \DFF_47/Q_reg  ( .QN(n351), .Q(G69), .CLK(CK), .DIN(G469) );
  dffs1 \DFF_46/Q_reg  ( .QN(n358), .Q(G68), .CLK(CK), .DIN(G464) );
  dffs1 \DFF_45/Q_reg  ( .QN(n352), .Q(G67), .CLK(CK), .DIN(G459) );
  dffs1 \DFF_44/Q_reg  ( .QN(n366), .Q(G66), .CLK(CK), .DIN(G451) );
  dffs1 \DFF_43/Q_reg  ( .Q(G65), .CLK(CK), .DIN(G447) );
  dffs1 \DFF_42/Q_reg  ( .Q(G64), .CLK(CK), .DIN(G441) );
  dffs1 \DFF_41/Q_reg  ( .QN(n350), .Q(G63), .CLK(CK), .DIN(G438) );
  dffs1 \DFF_40/Q_reg  ( .QN(n355), .CLK(CK), .DIN(G427) );
  dffs1 \DFF_39/Q_reg  ( .Q(G61), .CLK(CK), .DIN(G424) );
  dffs1 \DFF_38/Q_reg  ( .Q(G60), .CLK(CK), .DIN(G416) );
  dffs1 \DFF_37/Q_reg  ( .QN(n361), .Q(G59), .CLK(CK), .DIN(G408) );
  dffs1 \DFF_36/Q_reg  ( .Q(G58), .CLK(CK), .DIN(G405) );
  dffs1 \DFF_35/Q_reg  ( .Q(G57), .CLK(CK), .DIN(G397) );
  dffs1 \DFF_34/Q_reg  ( .Q(G56), .CLK(CK), .DIN(G392) );
  dffs1 \DFF_33/Q_reg  ( .Q(G55), .CLK(CK), .DIN(G384) );
  dffs1 \DFF_32/Q_reg  ( .Q(G54), .CLK(CK), .DIN(G379) );
  dffs1 \DFF_31/Q_reg  ( .Q(G53), .CLK(CK), .DIN(G373) );
  dffs1 \DFF_30/Q_reg  ( .QN(n373), .Q(G52), .CLK(CK), .DIN(G365) );
  dffs1 \DFF_29/Q_reg  ( .Q(G51), .CLK(CK), .DIN(G360) );
  dffs1 \DFF_28/Q_reg  ( .Q(G50), .CLK(CK), .DIN(G321) );
  dffs1 \DFF_27/Q_reg  ( .Q(G49), .CLK(CK), .DIN(G315) );
  dffs1 \DFF_26/Q_reg  ( .Q(G48), .CLK(CK), .DIN(G309) );
  dffs1 \DFF_25/Q_reg  ( .Q(G47), .CLK(CK), .DIN(G303) );
  dffs1 \DFF_24/Q_reg  ( .QN(n357), .Q(G46), .CLK(CK), .DIN(G260) );
  dffs1 \DFF_23/Q_reg  ( .QN(n354), .Q(G45), .CLK(CK), .DIN(G252) );
  dffs1 \DFF_22/Q_reg  ( .Q(G44), .CLK(CK), .DIN(G247) );
  dffs1 \DFF_21/Q_reg  ( .QN(n353), .Q(G43), .CLK(CK), .DIN(G242) );
  dffs1 \DFF_20/Q_reg  ( .Q(G42), .CLK(CK), .DIN(G237) );
  dffs1 \DFF_19/Q_reg  ( .Q(G41), .CLK(CK), .DIN(G218) );
  dffs1 \DFF_18/Q_reg  ( .QN(n365), .CLK(CK), .DIN(G214) );
  dffs1 \DFF_17/Q_reg  ( .Q(G39), .CLK(CK), .DIN(G208) );
  dffs1 \DFF_16/Q_reg  ( .QN(n364), .Q(G38), .CLK(CK), .DIN(G198) );
  dffs1 \DFF_15/Q_reg  ( .QN(n374), .Q(G37), .CLK(CK), .DIN(G193) );
  dffs1 \DFF_14/Q_reg  ( .QN(n348), .CLK(CK), .DIN(G189) );
  dffs1 \DFF_13/Q_reg  ( .Q(G35), .CLK(CK), .DIN(G175) );
  dffs1 \DFF_12/Q_reg  ( .QN(n359), .Q(G34), .CLK(CK), .DIN(G166) );
  dffs1 \DFF_11/Q_reg  ( .QN(n367), .Q(G33), .CLK(CK), .DIN(G159) );
  dffs1 \DFF_10/Q_reg  ( .QN(n375), .Q(G32), .CLK(CK), .DIN(G154) );
  dffs1 \DFF_9/Q_reg  ( .Q(G31), .CLK(CK), .DIN(G149) );
  dffs1 \DFF_8/Q_reg  ( .QN(n376), .Q(G30), .CLK(CK), .DIN(G144) );
  dffs1 \DFF_7/Q_reg  ( .QN(n347), .CLK(CK), .DIN(G140) );
  dffs1 \DFF_6/Q_reg  ( .Q(G28), .CLK(CK), .DIN(G129) );
  dffs1 \DFF_5/Q_reg  ( .QN(n362), .CLK(CK), .DIN(G125) );
  dffs1 \DFF_4/Q_reg  ( .QN(n368), .Q(G26), .CLK(CK), .DIN(G118) );
  dffs1 \DFF_3/Q_reg  ( .QN(n377), .Q(G25), .CLK(CK), .DIN(G113) );
  dffs1 \DFF_2/Q_reg  ( .QN(n349), .CLK(CK), .DIN(G109) );
  dffs1 \DFF_1/Q_reg  ( .Q(G23), .CLK(CK), .DIN(G328BF) );
  dffs1 \DFF_0/Q_reg  ( .Q(G22), .CLK(CK), .DIN(G332BF) );
endmodule

