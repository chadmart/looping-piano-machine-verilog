<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1(15:0)" />
        <signal name="ADDR(5:0)" />
        <signal name="RESET" />
        <signal name="XLXN_5" />
        <signal name="NOTE_CLK" />
        <signal name="XLXN_9(15:0)" />
        <signal name="XLXN_10" />
        <signal name="CLK_50KHZ" />
        <signal name="XLXN_21" />
        <signal name="sys_clk" />
        <signal name="tie1" />
        <signal name="tie0" />
        <signal name="tie0,tie0,tie0,tie0,tie0,tie0,tie0,tie1,tie1,tie1,tie1,tie1,tie0,tie1,tie0,tie0" />
        <signal name="XLXN_30(15:0)" />
        <signal name="CLK_50MHZ" />
        <signal name="XLXN_25" />
        <signal name="XLXN_38" />
        <signal name="XLXN_39" />
        <signal name="XLXN_40" />
        <signal name="XLXN_41" />
        <port polarity="Input" name="ADDR(5:0)" />
        <port polarity="Input" name="RESET" />
        <port polarity="Output" name="NOTE_CLK" />
        <port polarity="Input" name="sys_clk" />
        <port polarity="Input" name="CLK_50MHZ" />
        <blockdef name="Note64X16ROM">
            <timestamp>2013-4-21T18:45:42</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="comp16">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-384" height="320" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="64" y1="-320" y2="-320" x1="0" />
            <rect width="64" x="0" y="-332" height="24" />
            <line x2="320" y1="-224" y2="-224" x1="384" />
        </blockdef>
        <blockdef name="cb16ce">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="320" y1="-192" y2="-192" x1="384" />
            <rect width="64" x="320" y="-268" height="24" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="320" y1="-128" y2="-128" x1="384" />
            <rect width="256" x="64" y="-320" height="256" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="fjkc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="64" y1="-320" y2="-320" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <rect width="256" x="64" y="-384" height="320" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <block symbolname="Note64X16ROM" name="XLXI_1">
            <blockpin signalname="ADDR(5:0)" name="I(5:0)" />
            <blockpin signalname="XLXN_1(15:0)" name="DOUT(15:0)" />
        </block>
        <block symbolname="comp16" name="XLXI_2">
            <blockpin signalname="XLXN_9(15:0)" name="A(15:0)" />
            <blockpin signalname="XLXN_1(15:0)" name="B(15:0)" />
            <blockpin signalname="XLXN_39" name="EQ" />
        </block>
        <block symbolname="cb16ce" name="XLXI_4">
            <blockpin signalname="CLK_50KHZ" name="C" />
            <blockpin signalname="XLXN_10" name="CE" />
            <blockpin signalname="XLXN_38" name="CLR" />
            <blockpin name="CEO" />
            <blockpin signalname="XLXN_9(15:0)" name="Q(15:0)" />
            <blockpin name="TC" />
        </block>
        <block symbolname="vcc" name="XLXI_5">
            <blockpin signalname="XLXN_10" name="P" />
        </block>
        <block symbolname="vcc" name="XLXI_6">
            <blockpin signalname="XLXN_5" name="P" />
        </block>
        <block symbolname="fjkc" name="XLXI_10">
            <blockpin signalname="XLXN_39" name="C" />
            <blockpin signalname="RESET" name="CLR" />
            <blockpin signalname="XLXN_5" name="J" />
            <blockpin signalname="XLXN_5" name="K" />
            <blockpin signalname="NOTE_CLK" name="Q" />
        </block>
        <block symbolname="cb16ce" name="XLXI_12">
            <blockpin signalname="CLK_50MHZ" name="C" />
            <blockpin signalname="XLXN_25" name="CE" />
            <blockpin signalname="CLK_50KHZ" name="CLR" />
            <blockpin name="CEO" />
            <blockpin signalname="XLXN_30(15:0)" name="Q(15:0)" />
            <blockpin name="TC" />
        </block>
        <block symbolname="comp16" name="XLXI_13">
            <blockpin signalname="XLXN_30(15:0)" name="A(15:0)" />
            <blockpin signalname="tie0,tie0,tie0,tie0,tie0,tie0,tie0,tie1,tie1,tie1,tie1,tie1,tie0,tie1,tie0,tie0" name="B(15:0)" />
            <blockpin signalname="CLK_50KHZ" name="EQ" />
        </block>
        <block symbolname="vcc" name="XLXI_14">
            <blockpin signalname="XLXN_25" name="P" />
        </block>
        <block symbolname="vcc" name="XLXI_16">
            <blockpin signalname="tie1" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_17">
            <blockpin signalname="tie0" name="G" />
        </block>
        <block symbolname="or2" name="XLXI_18">
            <blockpin signalname="XLXN_39" name="I0" />
            <blockpin signalname="sys_clk" name="I1" />
            <blockpin signalname="XLXN_38" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1056" y="1152" name="XLXI_1" orien="R0">
        </instance>
        <branch name="XLXN_1(15:0)">
            <wire x2="1472" y1="1120" y2="1120" x1="1440" />
        </branch>
        <instance x="1472" y="1248" name="XLXI_2" orien="R0" />
        <instance x="2160" y="544" name="XLXI_4" orien="R0" />
        <branch name="ADDR(5:0)">
            <wire x2="1056" y1="1120" y2="1120" x1="912" />
        </branch>
        <branch name="RESET">
            <wire x2="2208" y1="1120" y2="1120" x1="2176" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="2192" y1="832" y2="832" x1="2128" />
            <wire x2="2208" y1="832" y2="832" x1="2192" />
            <wire x2="2192" y1="832" y2="896" x1="2192" />
            <wire x2="2208" y1="896" y2="896" x1="2192" />
        </branch>
        <branch name="NOTE_CLK">
            <wire x2="2656" y1="896" y2="896" x1="2592" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="2160" y1="352" y2="352" x1="2080" />
        </branch>
        <branch name="CLK_50KHZ">
            <wire x2="832" y1="688" y2="688" x1="752" />
            <wire x2="1312" y1="688" y2="688" x1="832" />
            <wire x2="832" y1="416" y2="688" x1="832" />
            <wire x2="2160" y1="416" y2="416" x1="1312" />
            <wire x2="1312" y1="416" y2="688" x1="1312" />
        </branch>
        <instance x="2016" y="352" name="XLXI_5" orien="R0" />
        <instance x="2064" y="832" name="XLXI_6" orien="R0" />
        <iomarker fontsize="28" x="2176" y="1120" name="RESET" orien="R180" />
        <iomarker fontsize="28" x="2656" y="896" name="NOTE_CLK" orien="R0" />
        <iomarker fontsize="28" x="912" y="1120" name="ADDR(5:0)" orien="R180" />
        <instance x="2208" y="1152" name="XLXI_10" orien="R0" />
        <branch name="sys_clk">
            <wire x2="1872" y1="480" y2="480" x1="1824" />
        </branch>
        <iomarker fontsize="28" x="1824" y="480" name="sys_clk" orien="R180" />
        <instance x="368" y="912" name="XLXI_13" orien="R0" />
        <instance x="288" y="1616" name="XLXI_16" orien="R0" />
        <instance x="672" y="1696" name="XLXI_17" orien="R0" />
        <branch name="tie1">
            <attrtext style="alignment:SOFT-VLEFT" attrname="Name" x="384" y="1616" type="branch" />
            <wire x2="352" y1="1616" y2="1632" x1="352" />
            <wire x2="384" y1="1632" y2="1632" x1="352" />
            <wire x2="384" y1="1616" y2="1632" x1="384" />
        </branch>
        <branch name="tie0">
            <attrtext style="alignment:SOFT-VLEFT" attrname="Name" x="736" y="1536" type="branch" />
            <wire x2="736" y1="1536" y2="1568" x1="736" />
        </branch>
        <branch name="tie0,tie0,tie0,tie0,tie0,tie0,tie0,tie1,tie1,tie1,tie1,tie1,tie0,tie1,tie0,tie0">
            <attrtext style="alignment:SOFT-RIGHT" attrname="Name" x="336" y="784" type="branch" />
            <wire x2="368" y1="784" y2="784" x1="336" />
        </branch>
        <branch name="XLXN_30(15:0)">
            <wire x2="1296" y1="32" y2="32" x1="352" />
            <wire x2="1296" y1="32" y2="192" x1="1296" />
            <wire x2="352" y1="32" y2="592" x1="352" />
            <wire x2="368" y1="592" y2="592" x1="352" />
            <wire x2="1296" y1="192" y2="192" x1="1216" />
        </branch>
        <branch name="CLK_50MHZ">
            <wire x2="832" y1="320" y2="320" x1="704" />
        </branch>
        <instance x="832" y="448" name="XLXI_12" orien="R0" />
        <branch name="XLXN_9(15:0)">
            <wire x2="2752" y1="144" y2="144" x1="1456" />
            <wire x2="2752" y1="144" y2="288" x1="2752" />
            <wire x2="1456" y1="144" y2="928" x1="1456" />
            <wire x2="1472" y1="928" y2="928" x1="1456" />
            <wire x2="2752" y1="288" y2="288" x1="2544" />
        </branch>
        <iomarker fontsize="28" x="704" y="320" name="CLK_50MHZ" orien="R180" />
        <instance x="608" y="256" name="XLXI_14" orien="R0" />
        <branch name="XLXN_25">
            <wire x2="832" y1="256" y2="256" x1="672" />
        </branch>
        <branch name="XLXN_38">
            <wire x2="2160" y1="512" y2="512" x1="2128" />
        </branch>
        <instance x="1872" y="608" name="XLXI_18" orien="R0" />
        <branch name="XLXN_39">
            <wire x2="1872" y1="544" y2="544" x1="1792" />
            <wire x2="1792" y1="544" y2="624" x1="1792" />
            <wire x2="1936" y1="624" y2="624" x1="1792" />
            <wire x2="1936" y1="624" y2="1024" x1="1936" />
            <wire x2="2208" y1="1024" y2="1024" x1="1936" />
            <wire x2="1936" y1="1024" y2="1024" x1="1856" />
        </branch>
    </sheet>
</drawing>