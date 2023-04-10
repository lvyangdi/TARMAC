module usb ( clk, rst, phy_tx_mode, usb_rst, txdp, txdn, txoe, rxd, rxdp, 
        rxdn, DataOut_i, TxValid_i, TxReady_o, RxValid_o, RxActhi1s1e_o, 
        RxError_o, DataIn_o, LineState_o );
  input [7:0] DataOut_i;
  output [7:0] DataIn_o;
  output [1:0] LineState_o;
  input clk, rst, phy_tx_mode, rxd, rxdp, rxdn, TxValid_i;
  output usb_rst, txdp, txdn, txoe, TxReady_o, RxValid_o, RxActhi1s1e_o,
         RxError_o;
  wire   i_rx_phy_sync_err, i_rx_phy_bit_stuff_err, i_rx_phy_byte_err,
         i_rx_phy_rxd_s1, i_rx_phy_rxdp_s_r, i_rx_phy_rxdn_s_r, n382, n395,
         n422, n434, n435, n436, n437, n438, n790, n791, n792, n793, n794,
         n795, n796, n797, n798, n799, n800, n801, n802, n803, n804, n805,
         n806, n807, n808, n809, n810, n811, n812, n813, n814, n815, n816,
         n817, n818, n819, n820, n821, n822, n823, n824, n825, n826, n827,
         n828, n829, n830, n831, n832, n833, n834, n835, n836, n837, n838,
         n839, n840, n841, n842, n843, n845, n846, n847, n848, n849, n850,
         n851, n852, n853, n854, n855, n856, n857, n858, n859, n860, n861,
         n862, n863, n864, n866, n868, i_tx_phy_sft_done, i_rx_phy_rxdp_s0,
         i_rx_phy_rxdn_s0, i_rx_phy_rxd_s0, i_rx_phy_rxd_s, i_rx_phy_fs_ce_r2,
         i_rx_phy_fs_ce_r1, n870, n871, n872, n873, n874, n875, n876, n877,
         n878, n879, n880, n881, n882, n883, n884, n885, n886, n887, n888,
         n889, n890, n891, n892, n893, n894, n895, n896, n897, n898, n899,
         n900, n901, n902, n903, n904, n905, n906, n907, n908, n909, n910,
         n911, n912, n913, n914, n915, n916, n917, n918, n919, n920, n921,
         n922, n923, n924, n925, n926, n927, n928, n929, n930, n931, n932,
         n933, n934, n935, n936, n937, n938, n939, n940, n941, n942, n943,
         n944, n945, n946, n947, n948, n949, n950, n951, n952, n953, n954,
         n955, n956, n957, n958, n959, n960, n961, n962, n963, n964, n965,
         n966, n967, n968, n969, n970, n971, n972, n973, n974, n975, n976,
         n977, n978, n979, n980, n981, n982, n983, n984, n985, n986, n987,
         n988, n989, n990, n991, n992, n993, n994, n995, n996, n997, n998,
         n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006, n1007, n1008,
         n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016, n1017, n1018,
         n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026, n1027, n1028,
         n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036, n1037, n1038,
         n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046, n1047, n1048,
         n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056, n1057, n1058,
         n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066, n1067, n1068,
         n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076, n1077, n1078,
         n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086, n1087, n1088,
         n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096, n1097, n1098,
         n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106, n1107, n1108,
         n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116, n1117, n1118,
         n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126, n1127, n1128,
         n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136, n1137, n1138,
         n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146, n1147, n1148,
         n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156, n1157, n1158,
         n1159, n1160, n1161, n1162, n1163, n1164, n1165, n1166, n1167, n1168,
         n1169, n1170, n1171, n1172, n1173, n1174, n1175, n1176, n1177, n1178,
         n1179, n1180, n1181, n1182, n1183, n1184, n1185, n1186, n1187, n1188,
         n1189, n1190, n1191, n1192, n1193, n1194, n1195, n1196, n1197, n1198,
         n1199, n1200, n1201, n1202, n1203, n1204, n1205, n1206, n1207, n1208,
         n1209, n1210, n1211, n1212, n1213, n1214, n1215, n1216, n1217, n1218,
         n1219, n1220, n1221, n1222, n1223, n1224, n1225, n1226, n1227, n1228,
         n1229, n1230, n1231, n1232, n1233, n1234, n1235, n1236, n1237, n1238,
         n1239, n1240, n1241, n1242, n1243, n1244, n1245, n1246, n1247, n1248,
         n1249, n1250, n1251, n1252, n1253, n1254, n1255, n1256, n1257, n1258,
         n1259, n1260, n1261, n1262, n1263, n1264, n1265, n1266, n1267, n1268,
         n1269, n1270, n1271, n1272, n1273, n1274, n1275, n1276, n1624, n1625,
         n1626, n1627;
  wire   [4:0] rst_cnt;
  wire   [7:0] i_tx_phy_hold_reg_d;
  wire   [7:0] i_tx_phy_hold_reg;

  dffs1  i_rx_phy_byte_err_reg ( .DIN(n790), .CLK(clk),         .Q(i_rx_phy_byte_err) );
  dffs1  i_rx_phy_se0_r_reg ( .DIN(n791), .CLK(clk),         .QN(n382) );
  dffs1  i_rx_phy_bit_stuff_err_reg ( .DIN(n792), .CLK(clk),         .Q(i_rx_phy_bit_stuff_err) );
  dffs1  i_rx_phy_rx_valid1_reg ( .DIN(n793), .CLK(clk),         .Q(n1235) );
  dffs1  \i_rx_phy_bit_cnt_reg[2]  ( .DIN(n794), .CLK(clk),         .Q(n1236), .QN(n906) );
  dffs1  \i_rx_phy_bit_cnt_reg[1]  ( .DIN(n795), .CLK(clk),         .Q(n1237), .QN(n893) );
  dffs1  \i_rx_phy_bit_cnt_reg[0]  ( .DIN(n796), .CLK(clk),         .Q(n1238), .QN(n894) );
  dffs1  \i_rx_phy_hold_reg_reg[0]  ( .DIN(n797), .CLK(clk),         .Q(DataIn_o[0]) );
  dffs1  \i_rx_phy_hold_reg_reg[1]  ( .DIN(n798), .CLK(clk),         .Q(DataIn_o[1]) );
  dffs1  \i_rx_phy_hold_reg_reg[2]  ( .DIN(n799), .CLK(clk),         .Q(DataIn_o[2]) );
  dffs1  \i_rx_phy_hold_reg_reg[3]  ( .DIN(n800), .CLK(clk),         .Q(DataIn_o[3]) );
  dffs1  \i_rx_phy_hold_reg_reg[4]  ( .DIN(n801), .CLK(clk),         .Q(DataIn_o[4]) );
  dffs1  \i_rx_phy_hold_reg_reg[5]  ( .DIN(n802), .CLK(clk),         .Q(DataIn_o[5]) );
  dffs1  \i_rx_phy_hold_reg_reg[6]  ( .DIN(n803), .CLK(clk),         .Q(DataIn_o[6]) );
  dffs1  \i_rx_phy_hold_reg_reg[7]  ( .DIN(n804), .CLK(clk),         .Q(DataIn_o[7]) );
  dffs1  \i_rx_phy_one_cnt_reg[2]  ( .DIN(n805), .CLK(clk),         .Q(n1239), .QN(n905) );
  dffs1  \i_rx_phy_one_cnt_reg[1]  ( .DIN(n806), .CLK(clk),         .Q(n1240), .QN(n892) );
  dffs1  \i_rx_phy_one_cnt_reg[0]  ( .DIN(n807), .CLK(clk),         .Q(n1241), .QN(n895) );
  dffs1  i_rx_phy_sd_nrzi_reg ( .DIN(n808), .CLK(clk),         .Q(n1242) );
  dffs1  i_rx_phy_shift_en_reg ( .DIN(n809), .CLK(clk),         .Q(n1243) );
  dffs1  \i_rx_phy_fs_state_reg[2]  ( .DIN(n810), .CLK(clk),         .Q(n1244), .QN(n873) );
  dffs1  \i_rx_phy_fs_state_reg[1]  ( .DIN(n811), .CLK(clk),         .Q(n1245), .QN(n881) );
  dffs1  \i_rx_phy_fs_state_reg[0]  ( .DIN(n812), .CLK(clk),         .Q(n1246), .QN(n880) );
  dffs1  i_rx_phy_sync_err_reg ( .DIN(n813), .CLK(clk),         .Q(i_rx_phy_sync_err) );
  dffs1  i_rx_phy_rx_acthi1s1e_reg ( .DIN(n814), .CLK(clk),         .Q(RxActhi1s1e_o), .QN(n395) );
  dffs1  i_rx_phy_rx_valid_r_reg ( .DIN(n815), .CLK(clk),         .Q(n1247) );
  dffs1  i_rx_phy_rx_valid_reg ( .DIN(n816), .CLK(clk),         .Q(RxValid_o) );
  dffs1  i_rx_phy_sd_r_reg ( .DIN(n817), .CLK(clk),         .Q(n1248), .QN(n904) );
  dffs1  usb_rst_reg ( .DIN(n818), .CLK(clk), .Q(usb_rst), 
        .QN(n903) );
  dffs1  \rst_cnt_reg[3]  ( .DIN(n819), .CLK(clk),         .Q(rst_cnt[3]), .QN(n888) );
  dffs1  \rst_cnt_reg[2]  ( .DIN(n820), .CLK(clk),         .Q(rst_cnt[2]), .QN(n889) );
  dffs1  \rst_cnt_reg[1]  ( .DIN(n821), .CLK(clk),         .Q(rst_cnt[1]), .QN(n872) );
  dffs1  \rst_cnt_reg[0]  ( .DIN(n822), .CLK(clk),         .Q(rst_cnt[0]), .QN(n890) );
  dffs1  \rst_cnt_reg[4]  ( .DIN(n823), .CLK(clk),         .Q(rst_cnt[4]), .QN(n902) );
  dffs1  i_tx_phy_txdn_reg ( .DIN(n824), .CLK(clk),         .Q(txdn) );
  dffs1  i_tx_phy_txdp_reg ( .DIN(n825), .CLK(clk),         .Q(txdp) );
  dffs1  i_tx_phy_sft_done_r_reg ( .DIN(i_tx_phy_sft_done), 
        .CLK(clk), 
        .Q(n1249) );
  dffs1  i_tx_phy_sft_done_reg ( .DIN(n826), .CLK(clk),         .Q(i_tx_phy_sft_done), .QN(n422) );
  dffs1  \i_tx_phy_bit_cnt_reg[2]  ( .DIN(n827), .CLK(clk),         .Q(n1250), .QN(n886) );
  dffs1  \i_tx_phy_bit_cnt_reg[1]  ( .DIN(n828), .CLK(clk),         .Q(n1251), .QN(n876) );
  dffs1  \i_tx_phy_bit_cnt_reg[0]  ( .DIN(n829), .CLK(clk),         .Q(n1252), .QN(n877) );
  dffs1  \i_tx_phy_one_cnt_reg[2]  ( .DIN(n830), .CLK(clk),         .Q(n1253), .QN(n887) );
  dffs1  \i_tx_phy_one_cnt_reg[1]  ( .DIN(n831), .CLK(clk),         .Q(n1254), .QN(n878) );
  dffs1  \i_tx_phy_one_cnt_reg[0]  ( .DIN(n832), .CLK(clk),         .Q(n1255), .QN(n885) );
  dffs1  i_tx_phy_sd_nrzi_o_reg ( .DIN(n833), .CLK(clk),         .Q(n1256) );
  dffs1  i_tx_phy_sd_bs_o_reg ( .DIN(n834), .CLK(clk),         .Q(n1232) );
  dffs1  i_tx_phy_sd_raw_o_reg ( .DIN(n835), .CLK(clk),         .Q(n1257) );
  dffs1  \i_tx_phy_hold_reg_d_reg[7]  ( .DIN(i_tx_phy_hold_reg[7]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[7]) );
  dffs1  \i_tx_phy_hold_reg_reg[7]  ( .DIN(n836), .CLK(clk),         .Q(i_tx_phy_hold_reg[7]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[6]  ( .DIN(i_tx_phy_hold_reg[6]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[6]) );
  dffs1  \i_tx_phy_hold_reg_reg[6]  ( .DIN(n837), .CLK(clk),         .Q(i_tx_phy_hold_reg[6]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[5]  ( .DIN(i_tx_phy_hold_reg[5]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[5]) );
  dffs1  \i_tx_phy_hold_reg_reg[5]  ( .DIN(n838), .CLK(clk),         .Q(i_tx_phy_hold_reg[5]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[4]  ( .DIN(i_tx_phy_hold_reg[4]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[4]) );
  dffs1  \i_tx_phy_hold_reg_reg[4]  ( .DIN(n839), .CLK(clk),         .Q(i_tx_phy_hold_reg[4]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[3]  ( .DIN(i_tx_phy_hold_reg[3]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[3]) );
  dffs1  \i_tx_phy_hold_reg_reg[3]  ( .DIN(n840), .CLK(clk),         .Q(i_tx_phy_hold_reg[3]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[2]  ( .DIN(i_tx_phy_hold_reg[2]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[2]) );
  dffs1  \i_tx_phy_hold_reg_reg[2]  ( .DIN(n841), .CLK(clk),         .Q(i_tx_phy_hold_reg[2]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[1]  ( .DIN(i_tx_phy_hold_reg[1]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[1]) );
  dffs1  \i_tx_phy_hold_reg_reg[1]  ( .DIN(n842), .CLK(clk),         .Q(i_tx_phy_hold_reg[1]) );
  dffs1  \i_tx_phy_hold_reg_d_reg[0]  ( .DIN(i_tx_phy_hold_reg[0]), 
        .CLK(clk), 
        .Q(i_tx_phy_hold_reg_d[0]) );
  dffs1  \i_tx_phy_hold_reg_reg[0]  ( .DIN(n843), .CLK(clk),         .Q(i_tx_phy_hold_reg[0]) );
  dffs1  i_tx_phy_ld_data_reg ( .DIN(n1627), .CLK(clk),         .Q(n1258), .QN(n883) );
  dffs1  i_tx_phy_TxReady_o_reg ( .DIN(n845), .CLK(clk),         .Q(TxReady_o) );
  dffs1  i_tx_phy_data_done_reg ( .DIN(n846), .CLK(clk),         .Q(n1259), .QN(n882) );
  dffs1  i_rx_phy_fs_ce_r2_reg ( .DIN(i_rx_phy_fs_ce_r1), 
        .CLK(clk), 
        .Q(i_rx_phy_fs_ce_r2) );
  dffs1  i_rx_phy_fs_ce_r1_reg ( .DIN(n847), .CLK(clk),         .Q(i_rx_phy_fs_ce_r1) );
  dffs1  \i_rx_phy_dpll_state_reg[1]  ( .DIN(n848), .CLK(
        clk), .Q(n1233), .QN(n901) );
  dffs1  \i_rx_phy_dpll_state_reg[0]  ( .DIN(n849), .CLK(
        clk), .Q(n1260), .QN(n899) );
  dffs1  i_rx_phy_rx_en_reg ( .DIN(txoe), .CLK(clk),         .Q(n1261), .QN(n891) );
  dffs1  i_tx_phy_txoe_reg ( .DIN(n850), .CLK(clk),         .Q(txoe) );
  dffs1  i_tx_phy_txoe_r2_reg ( .DIN(n851), .CLK(clk),         .Q(n1262) );
  dffs1  i_tx_phy_txoe_r1_reg ( .DIN(n852), .CLK(clk),         .Q(n1263) );
  dffs1  i_tx_phy_tx_ip_sync_reg ( .DIN(n853), .CLK(clk),         .Q(n1264) );
  dffs1  i_tx_phy_tx_ip_reg ( .DIN(n854), .CLK(clk),         .Q(n1265) );
  dffs1  i_tx_phy_append_eop_sync4_reg ( .DIN(n855), .CLK(
        clk), .Q(n1266), .QN(n898) );
  dffs1  i_tx_phy_append_eop_sync3_reg ( .DIN(n856), .CLK(
        clk), .Q(n1267), .QN(n879) );
  dffs1  i_tx_phy_append_eop_sync2_reg ( .DIN(n857), .CLK(
        clk), .Q(n1268), .QN(n897) );
  dffs1  i_tx_phy_append_eop_sync1_reg ( .DIN(n858), .CLK(
        clk), .Q(n1269) );
  dffs1  i_tx_phy_append_eop_reg ( .DIN(n859), .CLK(clk),         .Q(n1270) );
  dffs1  \i_tx_phy_state_reg[2]  ( .DIN(n860), .CLK(clk),         .Q(n1271), .QN(n871) );
  dffs1  \i_tx_phy_state_reg[1]  ( .DIN(n861), .CLK(clk),         .Q(n1272), .QN(n884) );
  dffs1  \i_tx_phy_state_reg[0]  ( .DIN(n862), .CLK(clk),         .Q(n1273), .QN(n875) );
  dffs1  i_rx_phy_se0_s_reg ( .DIN(n863), .CLK(clk),         .Q(n1274) );
  dffs1  i_rx_phy_fs_ce_reg ( .DIN(i_rx_phy_fs_ce_r2), 
        .CLK(clk), 
        .Q(n1275), .QN(n870) );
  dffs1  i_rx_phy_rxd_r_reg ( .DIN(i_rx_phy_rxd_s), .CLK(
        clk), .Q(n1276), .QN(n900) );
  dffs1  i_rx_phy_rxdn_s_reg ( .DIN(n864), .CLK(clk),         .QN(n874) );
  dffs1  i_rx_phy_rxdn_s_r_reg ( .DIN(n1626), .CLK(clk),         .Q(i_rx_phy_rxdn_s_r) );
  dffs1  i_rx_phy_rxdn_s1_reg ( .DIN(i_rx_phy_rxdn_s0), 
        .CLK(clk), 
        .Q(LineState_o[1]), .QN(n434) );
  dffs1  i_rx_phy_rxdn_s0_reg ( .DIN(rxdn), .CLK(clk),         .Q(i_rx_phy_rxdn_s0), .QN(n435) );
  dffs1  i_rx_phy_rxdp_s_reg ( .DIN(n866), .CLK(clk),         .Q(n1234), .QN(n896) );
  dffs1  i_rx_phy_rxdp_s_r_reg ( .DIN(n1625), .CLK(clk),         .Q(i_rx_phy_rxdp_s_r) );
  dffs1  i_rx_phy_rxdp_s1_reg ( .DIN(i_rx_phy_rxdp_s0), 
        .CLK(clk), 
        .Q(LineState_o[0]), .QN(n436) );
  dffs1  i_rx_phy_rxdp_s0_reg ( .DIN(rxdp), .CLK(clk),         .Q(i_rx_phy_rxdp_s0), .QN(n437) );
  dffs1  i_rx_phy_rxd_s_reg ( .DIN(n868), .CLK(clk),         .Q(i_rx_phy_rxd_s), .QN(n438) );
  dffs1  i_rx_phy_rxd_s1_reg ( .DIN(i_rx_phy_rxd_s0), .CLK(
        clk), .Q(i_rx_phy_rxd_s1) );
  dffs1  i_rx_phy_rxd_s0_reg ( .DIN(rxd), .CLK(clk),         .Q(i_rx_phy_rxd_s0) );
  hi1s1 U811 ( .DIN1(rst), .Q(n1624) );
  or2s1 U812 ( .DIN1(n907), .DIN2(n908), .Q(n868) );
  and2s1 U813 ( .DIN1(i_rx_phy_rxd_s), .DIN2(i_rx_phy_rxd_s0), .Q(n908) );
  and2s1 U814 ( .DIN1(n909), .DIN2(i_rx_phy_rxd_s1), .Q(n907) );
  or2s1 U815 ( .DIN1(i_rx_phy_rxd_s), .DIN2(i_rx_phy_rxd_s0), .Q(n909) );
  or2s1 U816 ( .DIN1(n1625), .DIN2(i_rx_phy_rxdp_s_r), .Q(n866) );
  hi1s1 U817 ( .DIN1(n910), .Q(n1625) );
  or2s1 U818 ( .DIN1(n437), .DIN2(n436), .Q(n910) );
  or2s1 U819 ( .DIN1(n1626), .DIN2(i_rx_phy_rxdn_s_r), .Q(n864) );
  hi1s1 U820 ( .DIN1(n911), .Q(n1626) );
  or2s1 U821 ( .DIN1(n435), .DIN2(n434), .Q(n911) );
  or2s1 U822 ( .DIN1(n912), .DIN2(n913), .Q(n863) );
  and2s1 U823 ( .DIN1(n1275), .DIN2(n791), .Q(n913) );
  and2s1 U824 ( .DIN1(n1274), .DIN2(n870), .Q(n912) );
  or2s1 U825 ( .DIN1(n914), .DIN2(n915), .Q(n862) );
  and2s1 U826 ( .DIN1(n916), .DIN2(n917), .Q(n915) );
  or2s1 U827 ( .DIN1(n918), .DIN2(n919), .Q(n917) );
  or2s1 U828 ( .DIN1(n920), .DIN2(n921), .Q(n919) );
  and2s1 U829 ( .DIN1(n1273), .DIN2(n922), .Q(n914) );
  or2s1 U830 ( .DIN1(n923), .DIN2(n924), .Q(n922) );
  or2s1 U831 ( .DIN1(n925), .DIN2(n926), .Q(n861) );
  and2s1 U832 ( .DIN1(n916), .DIN2(n927), .Q(n926) );
  or2s1 U833 ( .DIN1(n923), .DIN2(n928), .Q(n927) );
  and2s1 U834 ( .DIN1(n1272), .DIN2(n924), .Q(n925) );
  or2s1 U835 ( .DIN1(n921), .DIN2(n929), .Q(n860) );
  or2s1 U836 ( .DIN1(n930), .DIN2(n931), .Q(n929) );
  and2s1 U837 ( .DIN1(n916), .DIN2(n932), .Q(n931) );
  or2s1 U838 ( .DIN1(n933), .DIN2(n923), .Q(n932) );
  hi1s1 U839 ( .DIN1(n934), .Q(n923) );
  or2s1 U840 ( .DIN1(n935), .DIN2(n936), .Q(n934) );
  or2s1 U841 ( .DIN1(n937), .DIN2(n928), .Q(n936) );
  or2s1 U842 ( .DIN1(n920), .DIN2(n933), .Q(n935) );
  hi1s1 U843 ( .DIN1(n924), .Q(n916) );
  and2s1 U844 ( .DIN1(n1271), .DIN2(n924), .Q(n930) );
  or2s1 U845 ( .DIN1(n938), .DIN2(n939), .Q(n924) );
  or2s1 U846 ( .DIN1(n940), .DIN2(n941), .Q(n939) );
  and2s1 U847 ( .DIN1(n920), .DIN2(n942), .Q(n941) );
  and2s1 U848 ( .DIN1(n933), .DIN2(n879), .Q(n940) );
  and2s1 U849 ( .DIN1(n1273), .DIN2(n943), .Q(n933) );
  and2s1 U850 ( .DIN1(n871), .DIN2(n1272), .Q(n943) );
  or2s1 U851 ( .DIN1(n944), .DIN2(n945), .Q(n938) );
  or2s1 U852 ( .DIN1(n946), .DIN2(n947), .Q(n945) );
  and2s1 U853 ( .DIN1(n937), .DIN2(n948), .Q(n947) );
  or2s1 U854 ( .DIN1(n949), .DIN2(n870), .Q(n948) );
  and2s1 U855 ( .DIN1(n1267), .DIN2(n875), .Q(n949) );
  and2s1 U856 ( .DIN1(n928), .DIN2(n950), .Q(n944) );
  or2s1 U857 ( .DIN1(n951), .DIN2(n918), .Q(n928) );
  and2s1 U858 ( .DIN1(n875), .DIN2(n937), .Q(n921) );
  and2s1 U859 ( .DIN1(n884), .DIN2(n1271), .Q(n937) );
  or2s1 U860 ( .DIN1(n952), .DIN2(n953), .Q(n859) );
  and2s1 U861 ( .DIN1(n1270), .DIN2(n897), .Q(n953) );
  and2s1 U862 ( .DIN1(n954), .DIN2(n955), .Q(n952) );
  and2s1 U863 ( .DIN1(n918), .DIN2(n882), .Q(n954) );
  or2s1 U864 ( .DIN1(n956), .DIN2(n957), .Q(n858) );
  and2s1 U865 ( .DIN1(n1270), .DIN2(n1275), .Q(n957) );
  and2s1 U866 ( .DIN1(n1269), .DIN2(n870), .Q(n956) );
  or2s1 U867 ( .DIN1(n958), .DIN2(n959), .Q(n857) );
  and2s1 U868 ( .DIN1(n1269), .DIN2(n1275), .Q(n959) );
  and2s1 U869 ( .DIN1(n1268), .DIN2(n870), .Q(n958) );
  or2s1 U870 ( .DIN1(n960), .DIN2(n961), .Q(n856) );
  and2s1 U871 ( .DIN1(n1268), .DIN2(n1275), .Q(n961) );
  and2s1 U872 ( .DIN1(n1267), .DIN2(n962), .Q(n960) );
  or2s1 U873 ( .DIN1(n870), .DIN2(n898), .Q(n962) );
  or2s1 U874 ( .DIN1(n963), .DIN2(n964), .Q(n855) );
  and2s1 U875 ( .DIN1(n1267), .DIN2(n1275), .Q(n964) );
  and2s1 U876 ( .DIN1(n1266), .DIN2(n870), .Q(n963) );
  or2s1 U877 ( .DIN1(n965), .DIN2(n966), .Q(n854) );
  and2s1 U878 ( .DIN1(n1265), .DIN2(n879), .Q(n965) );
  or2s1 U879 ( .DIN1(n967), .DIN2(n968), .Q(n853) );
  and2s1 U880 ( .DIN1(n1265), .DIN2(n1275), .Q(n968) );
  or2s1 U881 ( .DIN1(n969), .DIN2(n970), .Q(n852) );
  and2s1 U882 ( .DIN1(n1264), .DIN2(n1275), .Q(n970) );
  and2s1 U883 ( .DIN1(n1263), .DIN2(n870), .Q(n969) );
  or2s1 U884 ( .DIN1(n971), .DIN2(n972), .Q(n851) );
  and2s1 U885 ( .DIN1(n1263), .DIN2(n1275), .Q(n972) );
  and2s1 U886 ( .DIN1(n1262), .DIN2(n870), .Q(n971) );
  or2s1 U887 ( .DIN1(n973), .DIN2(n974), .Q(n850) );
  and2s1 U888 ( .DIN1(n975), .DIN2(n1275), .Q(n974) );
  hi1s1 U889 ( .DIN1(n976), .Q(n975) );
  or2s1 U890 ( .DIN1(n1263), .DIN2(n1262), .Q(n976) );
  and2s1 U891 ( .DIN1(txoe), .DIN2(n870), .Q(n973) );
  or2s1 U892 ( .DIN1(n977), .DIN2(n978), .Q(n849) );
  and2s1 U893 ( .DIN1(n847), .DIN2(n979), .Q(n977) );
  hi1s1 U894 ( .DIN1(n980), .Q(n979) );
  or2s1 U895 ( .DIN1(n981), .DIN2(n847), .Q(n848) );
  and2s1 U896 ( .DIN1(n978), .DIN2(n1233), .Q(n981) );
  and2s1 U897 ( .DIN1(n980), .DIN2(n899), .Q(n978) );
  or2s1 U898 ( .DIN1(n891), .DIN2(n982), .Q(n980) );
  or2s1 U899 ( .DIN1(n983), .DIN2(n984), .Q(n982) );
  and2s1 U900 ( .DIN1(n438), .DIN2(n900), .Q(n984) );
  and2s1 U901 ( .DIN1(n1276), .DIN2(i_rx_phy_rxd_s), .Q(n983) );
  and2s1 U902 ( .DIN1(n901), .DIN2(n1260), .Q(n847) );
  hi1s1 U903 ( .DIN1(n985), .Q(n846) );
  or2s1 U904 ( .DIN1(n942), .DIN2(n986), .Q(n985) );
  and2s1 U905 ( .DIN1(n882), .DIN2(n1265), .Q(n986) );
  hi1s1 U906 ( .DIN1(TxValid_i), .Q(n942) );
  and2s1 U907 ( .DIN1(n1627), .DIN2(TxValid_i), .Q(n845) );
  and2s1 U908 ( .DIN1(n987), .DIN2(n955), .Q(n1627) );
  hi1s1 U909 ( .DIN1(n950), .Q(n955) );
  or2s1 U910 ( .DIN1(n422), .DIN2(n1249), .Q(n950) );
  or2s1 U911 ( .DIN1(n951), .DIN2(n946), .Q(n987) );
  and2s1 U912 ( .DIN1(n918), .DIN2(n1259), .Q(n946) );
  and2s1 U913 ( .DIN1(n1272), .DIN2(n988), .Q(n918) );
  and2s1 U914 ( .DIN1(n871), .DIN2(n875), .Q(n988) );
  and2s1 U915 ( .DIN1(n1273), .DIN2(n989), .Q(n951) );
  or2s1 U916 ( .DIN1(n990), .DIN2(n991), .Q(n843) );
  and2s1 U917 ( .DIN1(DataOut_i[0]), .DIN2(n992), .Q(n991) );
  and2s1 U918 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[0]), .Q(n990) );
  or2s1 U919 ( .DIN1(n994), .DIN2(n995), .Q(n842) );
  and2s1 U920 ( .DIN1(DataOut_i[1]), .DIN2(n992), .Q(n995) );
  and2s1 U921 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[1]), .Q(n994) );
  or2s1 U922 ( .DIN1(n996), .DIN2(n997), .Q(n841) );
  and2s1 U923 ( .DIN1(DataOut_i[2]), .DIN2(n992), .Q(n997) );
  and2s1 U924 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[2]), .Q(n996) );
  or2s1 U925 ( .DIN1(n998), .DIN2(n999), .Q(n840) );
  and2s1 U926 ( .DIN1(DataOut_i[3]), .DIN2(n992), .Q(n999) );
  and2s1 U927 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[3]), .Q(n998) );
  or2s1 U928 ( .DIN1(n1000), .DIN2(n1001), .Q(n839) );
  and2s1 U929 ( .DIN1(DataOut_i[4]), .DIN2(n992), .Q(n1001) );
  and2s1 U930 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[4]), .Q(n1000) );
  or2s1 U931 ( .DIN1(n1002), .DIN2(n1003), .Q(n838) );
  and2s1 U932 ( .DIN1(DataOut_i[5]), .DIN2(n992), .Q(n1003) );
  and2s1 U933 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[5]), .Q(n1002) );
  or2s1 U934 ( .DIN1(n1004), .DIN2(n1005), .Q(n837) );
  and2s1 U935 ( .DIN1(DataOut_i[6]), .DIN2(n992), .Q(n1005) );
  and2s1 U936 ( .DIN1(n1006), .DIN2(n1258), .Q(n992) );
  and2s1 U937 ( .DIN1(n993), .DIN2(i_tx_phy_hold_reg[6]), .Q(n1004) );
  and2s1 U938 ( .DIN1(n883), .DIN2(n1006), .Q(n993) );
  hi1s1 U939 ( .DIN1(n966), .Q(n1006) );
  or2s1 U940 ( .DIN1(n966), .DIN2(n1007), .Q(n836) );
  or2s1 U941 ( .DIN1(n1008), .DIN2(n1009), .Q(n1007) );
  and2s1 U942 ( .DIN1(DataOut_i[7]), .DIN2(n1258), .Q(n1009) );
  and2s1 U943 ( .DIN1(n883), .DIN2(i_tx_phy_hold_reg[7]), .Q(n1008) );
  and2s1 U944 ( .DIN1(n920), .DIN2(TxValid_i), .Q(n966) );
  and2s1 U945 ( .DIN1(n875), .DIN2(n989), .Q(n920) );
  and2s1 U946 ( .DIN1(n871), .DIN2(n884), .Q(n989) );
  and2s1 U947 ( .DIN1(n1010), .DIN2(n1264), .Q(n835) );
  and2s1 U948 ( .DIN1(n1011), .DIN2(n1012), .Q(n1010) );
  or2s1 U949 ( .DIN1(n1250), .DIN2(n1013), .Q(n1012) );
  or2s1 U950 ( .DIN1(n1014), .DIN2(n1015), .Q(n1013) );
  or2s1 U951 ( .DIN1(n1016), .DIN2(n1017), .Q(n1015) );
  and2s1 U952 ( .DIN1(n1018), .DIN2(i_tx_phy_hold_reg_d[1]), .Q(n1017) );
  and2s1 U953 ( .DIN1(n1019), .DIN2(n877), .Q(n1016) );
  and2s1 U954 ( .DIN1(n1020), .DIN2(n1021), .Q(n1019) );
  or2s1 U955 ( .DIN1(n1251), .DIN2(i_tx_phy_hold_reg_d[0]), .Q(n1021) );
  or2s1 U956 ( .DIN1(n876), .DIN2(i_tx_phy_hold_reg_d[2]), .Q(n1020) );
  and2s1 U957 ( .DIN1(n1022), .DIN2(i_tx_phy_hold_reg_d[3]), .Q(n1014) );
  or2s1 U958 ( .DIN1(n886), .DIN2(n1023), .Q(n1011) );
  or2s1 U959 ( .DIN1(n1024), .DIN2(n1025), .Q(n1023) );
  or2s1 U960 ( .DIN1(n1026), .DIN2(n1027), .Q(n1025) );
  and2s1 U961 ( .DIN1(n1018), .DIN2(i_tx_phy_hold_reg_d[5]), .Q(n1027) );
  and2s1 U962 ( .DIN1(n1028), .DIN2(n877), .Q(n1026) );
  and2s1 U963 ( .DIN1(n1029), .DIN2(n1030), .Q(n1028) );
  or2s1 U964 ( .DIN1(n1251), .DIN2(i_tx_phy_hold_reg_d[4]), .Q(n1030) );
  or2s1 U965 ( .DIN1(n876), .DIN2(i_tx_phy_hold_reg_d[6]), .Q(n1029) );
  and2s1 U966 ( .DIN1(n1022), .DIN2(i_tx_phy_hold_reg_d[7]), .Q(n1024) );
  or2s1 U967 ( .DIN1(n1031), .DIN2(n1032), .Q(n834) );
  and2s1 U968 ( .DIN1(n1232), .DIN2(n870), .Q(n1031) );
  or2s1 U969 ( .DIN1(n1033), .DIN2(n1034), .Q(n833) );
  hi1s1 U970 ( .DIN1(n1035), .Q(n1034) );
  and2s1 U971 ( .DIN1(n1264), .DIN2(n1263), .Q(n1035) );
  or2s1 U972 ( .DIN1(n1036), .DIN2(n1037), .Q(n1033) );
  hi1s1 U973 ( .DIN1(n1038), .Q(n1037) );
  or2s1 U974 ( .DIN1(n1039), .DIN2(n1256), .Q(n1038) );
  and2s1 U975 ( .DIN1(n1256), .DIN2(n1039), .Q(n1036) );
  or2s1 U976 ( .DIN1(n870), .DIN2(n1232), .Q(n1039) );
  or2s1 U977 ( .DIN1(n1040), .DIN2(n1041), .Q(n832) );
  and2s1 U978 ( .DIN1(n967), .DIN2(n1255), .Q(n1041) );
  and2s1 U979 ( .DIN1(n1264), .DIN2(n870), .Q(n967) );
  and2s1 U980 ( .DIN1(n1032), .DIN2(n885), .Q(n1040) );
  or2s1 U981 ( .DIN1(n1042), .DIN2(n1043), .Q(n831) );
  and2s1 U982 ( .DIN1(n1044), .DIN2(n1254), .Q(n1043) );
  and2s1 U983 ( .DIN1(n1264), .DIN2(n1045), .Q(n1044) );
  or2s1 U984 ( .DIN1(n1046), .DIN2(n870), .Q(n1045) );
  and2s1 U985 ( .DIN1(n1047), .DIN2(n1257), .Q(n1046) );
  and2s1 U986 ( .DIN1(n1048), .DIN2(n885), .Q(n1047) );
  and2s1 U987 ( .DIN1(n1049), .DIN2(n878), .Q(n1042) );
  and2s1 U988 ( .DIN1(n1032), .DIN2(n1255), .Q(n1049) );
  or2s1 U989 ( .DIN1(n1050), .DIN2(n1051), .Q(n830) );
  and2s1 U990 ( .DIN1(n1052), .DIN2(n1253), .Q(n1051) );
  and2s1 U991 ( .DIN1(n1264), .DIN2(n1053), .Q(n1052) );
  or2s1 U992 ( .DIN1(n1054), .DIN2(n870), .Q(n1053) );
  and2s1 U993 ( .DIN1(n1257), .DIN2(n878), .Q(n1054) );
  and2s1 U994 ( .DIN1(n1055), .DIN2(n887), .Q(n1050) );
  and2s1 U995 ( .DIN1(n1056), .DIN2(n1032), .Q(n1055) );
  and2s1 U996 ( .DIN1(n1057), .DIN2(n1257), .Q(n1032) );
  and2s1 U997 ( .DIN1(n1255), .DIN2(n1254), .Q(n1056) );
  or2s1 U998 ( .DIN1(n1058), .DIN2(n1059), .Q(n829) );
  and2s1 U999 ( .DIN1(n1060), .DIN2(n1252), .Q(n1059) );
  and2s1 U1000 ( .DIN1(n1264), .DIN2(n1061), .Q(n1060) );
  and2s1 U1001 ( .DIN1(n1057), .DIN2(n877), .Q(n1058) );
  or2s1 U1002 ( .DIN1(n1062), .DIN2(n1063), .Q(n828) );
  and2s1 U1003 ( .DIN1(n1057), .DIN2(n1018), .Q(n1063) );
  and2s1 U1004 ( .DIN1(n876), .DIN2(n1252), .Q(n1018) );
  and2s1 U1005 ( .DIN1(n1064), .DIN2(n1251), .Q(n1062) );
  and2s1 U1006 ( .DIN1(n1264), .DIN2(n1065), .Q(n1064) );
  or2s1 U1007 ( .DIN1(n1066), .DIN2(n1067), .Q(n827) );
  and2s1 U1008 ( .DIN1(n1068), .DIN2(n1250), .Q(n1067) );
  and2s1 U1009 ( .DIN1(n1264), .DIN2(n1069), .Q(n1068) );
  or2s1 U1010 ( .DIN1(n876), .DIN2(n1065), .Q(n1069) );
  or2s1 U1011 ( .DIN1(n877), .DIN2(n1061), .Q(n1065) );
  hi1s1 U1012 ( .DIN1(n1070), .Q(n1061) );
  and2s1 U1013 ( .DIN1(n1071), .DIN2(n886), .Q(n1066) );
  and2s1 U1014 ( .DIN1(n1057), .DIN2(n1022), .Q(n1071) );
  and2s1 U1015 ( .DIN1(n1264), .DIN2(n1070), .Q(n1057) );
  and2s1 U1016 ( .DIN1(n1048), .DIN2(n1275), .Q(n1070) );
  and2s1 U1017 ( .DIN1(n1072), .DIN2(n1250), .Q(n826) );
  and2s1 U1018 ( .DIN1(n1022), .DIN2(n1048), .Q(n1072) );
  or2s1 U1019 ( .DIN1(n887), .DIN2(n1073), .Q(n1048) );
  or2s1 U1020 ( .DIN1(n1255), .DIN2(n878), .Q(n1073) );
  and2s1 U1021 ( .DIN1(n1251), .DIN2(n1252), .Q(n1022) );
  or2s1 U1022 ( .DIN1(n1074), .DIN2(n1075), .Q(n825) );
  and2s1 U1023 ( .DIN1(n1076), .DIN2(n1275), .Q(n1075) );
  and2s1 U1024 ( .DIN1(n1256), .DIN2(n1077), .Q(n1076) );
  or2s1 U1025 ( .DIN1(n879), .DIN2(n1078), .Q(n1077) );
  and2s1 U1026 ( .DIN1(txdp), .DIN2(n870), .Q(n1074) );
  or2s1 U1027 ( .DIN1(n1079), .DIN2(n1080), .Q(n824) );
  and2s1 U1028 ( .DIN1(n1081), .DIN2(n1275), .Q(n1080) );
  or2s1 U1029 ( .DIN1(n1082), .DIN2(n1083), .Q(n1081) );
  and2s1 U1030 ( .DIN1(n1267), .DIN2(n1078), .Q(n1083) );
  hi1s1 U1031 ( .DIN1(n1084), .Q(n1082) );
  or2s1 U1032 ( .DIN1(n1085), .DIN2(n1267), .Q(n1084) );
  or2s1 U1033 ( .DIN1(n1078), .DIN2(n1256), .Q(n1085) );
  hi1s1 U1034 ( .DIN1(phy_tx_mode), .Q(n1078) );
  and2s1 U1035 ( .DIN1(txdn), .DIN2(n870), .Q(n1079) );
  or2s1 U1036 ( .DIN1(n1086), .DIN2(n1087), .Q(n823) );
  and2s1 U1037 ( .DIN1(n1088), .DIN2(n902), .Q(n1087) );
  and2s1 U1038 ( .DIN1(n1089), .DIN2(rst_cnt[3]), .Q(n1088) );
  and2s1 U1039 ( .DIN1(rst_cnt[4]), .DIN2(n1090), .Q(n1086) );
  or2s1 U1040 ( .DIN1(n1091), .DIN2(n1092), .Q(n1090) );
  and2s1 U1041 ( .DIN1(n1093), .DIN2(n888), .Q(n1091) );
  or2s1 U1042 ( .DIN1(n1094), .DIN2(n1095), .Q(n822) );
  and2s1 U1043 ( .DIN1(n1096), .DIN2(rst_cnt[0]), .Q(n1095) );
  or2s1 U1044 ( .DIN1(n1097), .DIN2(n1098), .Q(n821) );
  and2s1 U1045 ( .DIN1(n1099), .DIN2(n872), .Q(n1098) );
  and2s1 U1046 ( .DIN1(n1093), .DIN2(rst_cnt[0]), .Q(n1099) );
  and2s1 U1047 ( .DIN1(rst_cnt[1]), .DIN2(n1100), .Q(n1097) );
  or2s1 U1048 ( .DIN1(n1101), .DIN2(n1102), .Q(n820) );
  and2s1 U1049 ( .DIN1(n1103), .DIN2(n889), .Q(n1102) );
  and2s1 U1050 ( .DIN1(n1104), .DIN2(n1093), .Q(n1103) );
  and2s1 U1051 ( .DIN1(rst_cnt[1]), .DIN2(rst_cnt[0]), .Q(n1104) );
  and2s1 U1052 ( .DIN1(rst_cnt[2]), .DIN2(n1105), .Q(n1101) );
  or2s1 U1053 ( .DIN1(n1106), .DIN2(n1100), .Q(n1105) );
  or2s1 U1054 ( .DIN1(n1094), .DIN2(n1096), .Q(n1100) );
  and2s1 U1055 ( .DIN1(n1093), .DIN2(n890), .Q(n1094) );
  and2s1 U1056 ( .DIN1(n1093), .DIN2(n872), .Q(n1106) );
  or2s1 U1057 ( .DIN1(n1107), .DIN2(n1108), .Q(n819) );
  and2s1 U1058 ( .DIN1(n1089), .DIN2(n888), .Q(n1108) );
  and2s1 U1059 ( .DIN1(n1093), .DIN2(n1109), .Q(n1089) );
  and2s1 U1060 ( .DIN1(rst_cnt[3]), .DIN2(n1092), .Q(n1107) );
  or2s1 U1061 ( .DIN1(n1110), .DIN2(n1096), .Q(n1092) );
  and2s1 U1062 ( .DIN1(n436), .DIN2(n1111), .Q(n1096) );
  and2s1 U1063 ( .DIN1(n1112), .DIN2(n434), .Q(n1111) );
  hi1s1 U1064 ( .DIN1(n1093), .Q(n1112) );
  and2s1 U1065 ( .DIN1(n1093), .DIN2(n1113), .Q(n1110) );
  and2s1 U1066 ( .DIN1(n1114), .DIN2(n1115), .Q(n1093) );
  and2s1 U1067 ( .DIN1(n434), .DIN2(n436), .Q(n1115) );
  and2s1 U1068 ( .DIN1(n903), .DIN2(n1275), .Q(n1114) );
  and2s1 U1069 ( .DIN1(n1116), .DIN2(rst_cnt[4]), .Q(n818) );
  and2s1 U1070 ( .DIN1(rst_cnt[3]), .DIN2(n1109), .Q(n1116) );
  hi1s1 U1071 ( .DIN1(n1113), .Q(n1109) );
  or2s1 U1072 ( .DIN1(n889), .DIN2(n1117), .Q(n1113) );
  or2s1 U1073 ( .DIN1(n890), .DIN2(n872), .Q(n1117) );
  or2s1 U1074 ( .DIN1(n1118), .DIN2(n1119), .Q(n817) );
  and2s1 U1075 ( .DIN1(n1275), .DIN2(i_rx_phy_rxd_s), .Q(n1119) );
  and2s1 U1076 ( .DIN1(n1248), .DIN2(n870), .Q(n1118) );
  and2s1 U1077 ( .DIN1(n1235), .DIN2(n1120), .Q(n816) );
  or2s1 U1078 ( .DIN1(n1121), .DIN2(RxValid_o), .Q(n815) );
  and2s1 U1079 ( .DIN1(n1247), .DIN2(n870), .Q(n1121) );
  or2s1 U1080 ( .DIN1(n1122), .DIN2(n1123), .Q(n814) );
  hi1s1 U1081 ( .DIN1(n1124), .Q(n1123) );
  or2s1 U1082 ( .DIN1(n1125), .DIN2(n395), .Q(n1124) );
  and2s1 U1083 ( .DIN1(n791), .DIN2(n1247), .Q(n1125) );
  and2s1 U1084 ( .DIN1(n1126), .DIN2(n1127), .Q(n1122) );
  and2s1 U1085 ( .DIN1(n1128), .DIN2(n1261), .Q(n1126) );
  and2s1 U1086 ( .DIN1(n1129), .DIN2(n1130), .Q(n813) );
  hi1s1 U1087 ( .DIN1(n1131), .Q(n1130) );
  or2s1 U1088 ( .DIN1(n1132), .DIN2(n1133), .Q(n1131) );
  or2s1 U1089 ( .DIN1(n1134), .DIN2(n1135), .Q(n1132) );
  and2s1 U1090 ( .DIN1(n1245), .DIN2(n1128), .Q(n1134) );
  and2s1 U1091 ( .DIN1(n1136), .DIN2(n1137), .Q(n1129) );
  or2s1 U1092 ( .DIN1(n873), .DIN2(n1138), .Q(n1137) );
  or2s1 U1093 ( .DIN1(n1139), .DIN2(n1140), .Q(n812) );
  and2s1 U1094 ( .DIN1(n1133), .DIN2(n1141), .Q(n1140) );
  and2s1 U1095 ( .DIN1(n1142), .DIN2(n880), .Q(n1133) );
  or2s1 U1096 ( .DIN1(n1143), .DIN2(n1144), .Q(n1142) );
  and2s1 U1097 ( .DIN1(n1246), .DIN2(n1145), .Q(n1139) );
  or2s1 U1098 ( .DIN1(n1146), .DIN2(n1147), .Q(n811) );
  and2s1 U1099 ( .DIN1(n1148), .DIN2(n881), .Q(n1147) );
  and2s1 U1100 ( .DIN1(n1135), .DIN2(n1141), .Q(n1148) );
  and2s1 U1101 ( .DIN1(n1245), .DIN2(n1149), .Q(n1146) );
  or2s1 U1102 ( .DIN1(n1150), .DIN2(n1151), .Q(n810) );
  and2s1 U1103 ( .DIN1(n1152), .DIN2(n873), .Q(n1151) );
  and2s1 U1104 ( .DIN1(n1153), .DIN2(n1135), .Q(n1152) );
  and2s1 U1105 ( .DIN1(n1141), .DIN2(n1245), .Q(n1153) );
  hi1s1 U1106 ( .DIN1(n1145), .Q(n1141) );
  and2s1 U1107 ( .DIN1(n1244), .DIN2(n1154), .Q(n1150) );
  or2s1 U1108 ( .DIN1(n1155), .DIN2(n1149), .Q(n1154) );
  or2s1 U1109 ( .DIN1(n1156), .DIN2(n1145), .Q(n1149) );
  or2s1 U1110 ( .DIN1(n1157), .DIN2(n1158), .Q(n1145) );
  and2s1 U1111 ( .DIN1(n1159), .DIN2(n1143), .Q(n1157) );
  and2s1 U1112 ( .DIN1(n881), .DIN2(n873), .Q(n1143) );
  and2s1 U1113 ( .DIN1(n1138), .DIN2(n880), .Q(n1159) );
  and2s1 U1114 ( .DIN1(n1144), .DIN2(n880), .Q(n1156) );
  and2s1 U1115 ( .DIN1(n1135), .DIN2(n881), .Q(n1155) );
  and2s1 U1116 ( .DIN1(n1246), .DIN2(n1160), .Q(n1135) );
  and2s1 U1117 ( .DIN1(n874), .DIN2(n1261), .Q(n1160) );
  or2s1 U1118 ( .DIN1(n1161), .DIN2(n1162), .Q(n809) );
  and2s1 U1119 ( .DIN1(n1275), .DIN2(n1163), .Q(n1161) );
  or2s1 U1120 ( .DIN1(n1164), .DIN2(RxActhi1s1e_o), .Q(n1163) );
  and2s1 U1121 ( .DIN1(n1127), .DIN2(n1128), .Q(n1164) );
  and2s1 U1122 ( .DIN1(n1246), .DIN2(n1244), .Q(n1128) );
  and2s1 U1123 ( .DIN1(n1165), .DIN2(n1136), .Q(n1127) );
  hi1s1 U1124 ( .DIN1(n1158), .Q(n1136) );
  or2s1 U1125 ( .DIN1(n1166), .DIN2(n1167), .Q(n1158) );
  or2s1 U1126 ( .DIN1(n870), .DIN2(RxActhi1s1e_o), .Q(n1167) );
  or2s1 U1127 ( .DIN1(n1274), .DIN2(n791), .Q(n1166) );
  or2s1 U1128 ( .DIN1(n1144), .DIN2(n1168), .Q(n1165) );
  and2s1 U1129 ( .DIN1(n896), .DIN2(n1245), .Q(n1168) );
  hi1s1 U1130 ( .DIN1(n1138), .Q(n1144) );
  or2s1 U1131 ( .DIN1(n1234), .DIN2(n891), .Q(n1138) );
  or2s1 U1132 ( .DIN1(n395), .DIN2(n1169), .Q(n808) );
  or2s1 U1133 ( .DIN1(n1170), .DIN2(n1171), .Q(n1169) );
  and2s1 U1134 ( .DIN1(n1172), .DIN2(n1275), .Q(n1171) );
  or2s1 U1135 ( .DIN1(n1173), .DIN2(n1174), .Q(n1172) );
  and2s1 U1136 ( .DIN1(n438), .DIN2(n904), .Q(n1174) );
  and2s1 U1137 ( .DIN1(n1248), .DIN2(i_rx_phy_rxd_s), .Q(n1173) );
  and2s1 U1138 ( .DIN1(n1242), .DIN2(n870), .Q(n1170) );
  or2s1 U1139 ( .DIN1(n1175), .DIN2(n1176), .Q(n807) );
  and2s1 U1140 ( .DIN1(n1162), .DIN2(n1241), .Q(n1176) );
  or2s1 U1141 ( .DIN1(n1177), .DIN2(n1178), .Q(n806) );
  and2s1 U1142 ( .DIN1(n1179), .DIN2(n892), .Q(n1178) );
  and2s1 U1143 ( .DIN1(n1180), .DIN2(n1241), .Q(n1179) );
  and2s1 U1144 ( .DIN1(n1240), .DIN2(n1181), .Q(n1177) );
  or2s1 U1145 ( .DIN1(n1175), .DIN2(n1162), .Q(n1181) );
  and2s1 U1146 ( .DIN1(n1180), .DIN2(n895), .Q(n1175) );
  or2s1 U1147 ( .DIN1(n1182), .DIN2(n1183), .Q(n805) );
  and2s1 U1148 ( .DIN1(n1184), .DIN2(n905), .Q(n1183) );
  and2s1 U1149 ( .DIN1(n1185), .DIN2(n1180), .Q(n1184) );
  and2s1 U1150 ( .DIN1(n1241), .DIN2(n1240), .Q(n1185) );
  and2s1 U1151 ( .DIN1(n1239), .DIN2(n1186), .Q(n1182) );
  or2s1 U1152 ( .DIN1(n1187), .DIN2(n1162), .Q(n1186) );
  and2s1 U1153 ( .DIN1(n870), .DIN2(n1243), .Q(n1162) );
  and2s1 U1154 ( .DIN1(n1180), .DIN2(n892), .Q(n1187) );
  or2s1 U1155 ( .DIN1(n1188), .DIN2(n1180), .Q(n804) );
  and2s1 U1156 ( .DIN1(n1242), .DIN2(n1189), .Q(n1180) );
  and2s1 U1157 ( .DIN1(n1190), .DIN2(DataIn_o[7]), .Q(n1188) );
  or2s1 U1158 ( .DIN1(n1191), .DIN2(n1192), .Q(n803) );
  and2s1 U1159 ( .DIN1(n1190), .DIN2(DataIn_o[6]), .Q(n1192) );
  and2s1 U1160 ( .DIN1(n1189), .DIN2(DataIn_o[7]), .Q(n1191) );
  or2s1 U1161 ( .DIN1(n1193), .DIN2(n1194), .Q(n802) );
  and2s1 U1162 ( .DIN1(n1190), .DIN2(DataIn_o[5]), .Q(n1194) );
  and2s1 U1163 ( .DIN1(n1189), .DIN2(DataIn_o[6]), .Q(n1193) );
  or2s1 U1164 ( .DIN1(n1195), .DIN2(n1196), .Q(n801) );
  and2s1 U1165 ( .DIN1(n1190), .DIN2(DataIn_o[4]), .Q(n1196) );
  and2s1 U1166 ( .DIN1(n1189), .DIN2(DataIn_o[5]), .Q(n1195) );
  or2s1 U1167 ( .DIN1(n1197), .DIN2(n1198), .Q(n800) );
  and2s1 U1168 ( .DIN1(n1190), .DIN2(DataIn_o[3]), .Q(n1198) );
  and2s1 U1169 ( .DIN1(n1189), .DIN2(DataIn_o[4]), .Q(n1197) );
  or2s1 U1170 ( .DIN1(n1199), .DIN2(n1200), .Q(n799) );
  and2s1 U1171 ( .DIN1(n1190), .DIN2(DataIn_o[2]), .Q(n1200) );
  and2s1 U1172 ( .DIN1(n1189), .DIN2(DataIn_o[3]), .Q(n1199) );
  or2s1 U1173 ( .DIN1(n1201), .DIN2(n1202), .Q(n798) );
  and2s1 U1174 ( .DIN1(n1190), .DIN2(DataIn_o[1]), .Q(n1202) );
  and2s1 U1175 ( .DIN1(n1189), .DIN2(DataIn_o[2]), .Q(n1201) );
  or2s1 U1176 ( .DIN1(n1203), .DIN2(n1204), .Q(n797) );
  and2s1 U1177 ( .DIN1(n1190), .DIN2(DataIn_o[0]), .Q(n1204) );
  hi1s1 U1178 ( .DIN1(n1189), .Q(n1190) );
  and2s1 U1179 ( .DIN1(n1189), .DIN2(DataIn_o[1]), .Q(n1203) );
  or2s1 U1180 ( .DIN1(n1205), .DIN2(n1206), .Q(n796) );
  and2s1 U1181 ( .DIN1(n1207), .DIN2(n1238), .Q(n1206) );
  and2s1 U1182 ( .DIN1(n1243), .DIN2(n1208), .Q(n1207) );
  and2s1 U1183 ( .DIN1(n1189), .DIN2(n894), .Q(n1205) );
  or2s1 U1184 ( .DIN1(n1209), .DIN2(n1210), .Q(n795) );
  and2s1 U1185 ( .DIN1(n1211), .DIN2(n1237), .Q(n1210) );
  and2s1 U1186 ( .DIN1(n1243), .DIN2(n1212), .Q(n1211) );
  and2s1 U1187 ( .DIN1(n1213), .DIN2(n893), .Q(n1209) );
  or2s1 U1188 ( .DIN1(n1214), .DIN2(n1215), .Q(n794) );
  and2s1 U1189 ( .DIN1(n1216), .DIN2(n1236), .Q(n1215) );
  and2s1 U1190 ( .DIN1(n1243), .DIN2(n1217), .Q(n1216) );
  and2s1 U1191 ( .DIN1(n1218), .DIN2(n906), .Q(n1214) );
  and2s1 U1192 ( .DIN1(n1213), .DIN2(n1237), .Q(n1218) );
  and2s1 U1193 ( .DIN1(n1238), .DIN2(n1189), .Q(n1213) );
  and2s1 U1194 ( .DIN1(n1120), .DIN2(n1243), .Q(n1189) );
  hi1s1 U1195 ( .DIN1(n1208), .Q(n1120) );
  or2s1 U1196 ( .DIN1(n1219), .DIN2(n1220), .Q(n793) );
  and2s1 U1197 ( .DIN1(n1235), .DIN2(n1208), .Q(n1220) );
  and2s1 U1198 ( .DIN1(n1221), .DIN2(n1236), .Q(n1219) );
  hi1s1 U1199 ( .DIN1(n1217), .Q(n1221) );
  or2s1 U1200 ( .DIN1(n893), .DIN2(n1212), .Q(n1217) );
  or2s1 U1201 ( .DIN1(n1208), .DIN2(n894), .Q(n1212) );
  or2s1 U1202 ( .DIN1(n1222), .DIN2(n870), .Q(n1208) );
  and2s1 U1203 ( .DIN1(n1223), .DIN2(n1224), .Q(n792) );
  and2s1 U1204 ( .DIN1(n1225), .DIN2(n1275), .Q(n1224) );
  and2s1 U1205 ( .DIN1(n1226), .DIN2(RxActhi1s1e_o), .Q(n1225) );
  hi1s1 U1206 ( .DIN1(n791), .Q(n1226) );
  and2s1 U1207 ( .DIN1(n1222), .DIN2(n1242), .Q(n1223) );
  and2s1 U1208 ( .DIN1(n1239), .DIN2(n1227), .Q(n1222) );
  and2s1 U1209 ( .DIN1(n895), .DIN2(n1240), .Q(n1227) );
  and2s1 U1210 ( .DIN1(n1228), .DIN2(n1229), .Q(n790) );
  and2s1 U1211 ( .DIN1(RxActhi1s1e_o), .DIN2(n382), .Q(n1229) );
  and2s1 U1212 ( .DIN1(n791), .DIN2(n1230), .Q(n1228) );
  or2s1 U1213 ( .DIN1(n1237), .DIN2(n1236), .Q(n1230) );
  and2s1 U1214 ( .DIN1(n896), .DIN2(n874), .Q(n791) );
  or2s1 U1215 ( .DIN1(i_rx_phy_byte_err), .DIN2(n1231), .Q(RxError_o) );
  or2s1 U1216 ( .DIN1(i_rx_phy_bit_stuff_err), .DIN2(i_rx_phy_sync_err), .Q(n1231) );
endmodule

