module c17 ( G1gat, G2gat, G3gat, G6gat, G7gat, G22gat, G23gat );
input  G1gat, G2gat, G3gat, G6gat, G7gat;
output G22gat, G23gat;
    wire n7, n8, n9, n10, n11;
    nor2s1 U1 ( .Q(G23gat), .DIN1(n7), .DIN2(n8) );
    nnd2s1 U2 ( .Q(G22gat), .DIN1(n9), .DIN2(n10) );
    nor2s1 U3 ( .Q(n8), .DIN1(G2gat), .DIN2(G7gat) );
    nnd2s1 U4 ( .Q(n11), .DIN1(G3gat), .DIN2(G6gat) );
    hi1s1 U5 ( .Q(n7), .DIN(n11) );
    nnd2s1 U6 ( .Q(n10), .DIN1(G2gat), .DIN2(n11) );
    nnd2s1 U7 ( .Q(n9), .DIN1(G1gat), .DIN2(G3gat) );
endmodule
