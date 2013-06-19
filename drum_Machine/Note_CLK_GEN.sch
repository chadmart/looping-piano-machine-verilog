<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="ADDR(4:0)" />
        <signal name="XLXN_4(31:0)" />
        <signal name="XLXN_6" />
        <signal name="NOTE_CLK" />
        <signal name="RESET" />
        <signal name="XLXN_9" />
        <signal name="CLK_50KHZ" />
        <signal name="XLXN_12" />
        <signal name="XLXN_14(7:0)" />
        <port polarity="Input" name="ADDR(4:0)" />
        <port polarity="Output" name="NOTE_CLK" />
        <port polarity="Input" name="RESET" />
        <port polarity="Input" name="CLK_50KHZ" />
        <blockdef name="Note32X8ROM">
            <timestamp>2013-4-20T19:56:35</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="comp8">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-384" height="320" />
            <line x2="320" y1="-224" y2="-224" x1="384" />
            <rect width="64" x="0" y="-332" height="24" />
            <line x2="64" y1="-320" y2="-320" x1="0" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
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
        <blockdef name="cb8ce">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="320" y1="-128" y2="-128" x1="384" />
            <rect width="64" x="320" y="-268" height="24" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="320" y1="-192" y2="-192" x1="384" />
            <rect width="256" x="64" y="-320" height="256" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <block symbolname="Note32X8ROM" name="XLXI_8">
            <blockpin signalname="ADDR(4:0)" name="I(4:0)" />
            <blockpin signalname="XLXN_4(31:0)" name="DOUT(7:0)" />
        </block>
        <block symbolname="comp8" name="XLXI_9">
            <blockpin signalname="XLXN_14(7:0)" name="A(7:0)" />
            <blockpin signalname="XLXN_4(31:0)" name="B(7:0)" />
            <blockpin signalname="XLXN_12" name="EQ" />
        </block>
        <block symbolname="fjkc" name="XLXI_10">
            <blockpin signalname="XLXN_12" name="C" />
            <blockpin signalname="RESET" name="CLR" />
            <blockpin signalname="XLXN_6" name="J" />
            <blockpin signalname="XLXN_6" name="K" />
            <blockpin signalname="NOTE_CLK" name="Q" />
        </block>
        <block symbolname="cb8ce" name="XLXI_11">
            <blockpin signalname="CLK_50KHZ" name="C" />
            <blockpin signalname="XLXN_9" name="CE" />
            <blockpin signalname="XLXN_12" name="CLR" />
            <blockpin name="CEO" />
            <blockpin signalname="XLXN_14(7:0)" name="Q(7:0)" />
            <blockpin name="TC" />
        </block>
        <block symbolname="vcc" name="XLXI_12">
            <blockpin signalname="XLXN_9" name="P" />
        </block>
        <block symbolname="vcc" name="XLXI_16">
            <blockpin signalname="XLXN_6" name="P" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="ADDR(4:0)">
            <attrtext style="alignment:SOFT-BCENTER" attrname="Name" x="928" y="1232" type="branch" />
            <wire x2="928" y1="1232" y2="1232" x1="864" />
            <wire x2="976" y1="1232" y2="1232" x1="928" />
        </branch>
        <iomarker fontsize="28" x="864" y="1232" name="ADDR(4:0)" orien="R180" />
        <branch name="XLXN_4(31:0)">
            <wire x2="1392" y1="1232" y2="1232" x1="1360" />
        </branch>
        <instance x="976" y="1264" name="XLXI_8" orien="R0">
        </instance>
        <instance x="1392" y="1360" name="XLXI_9" orien="R0" />
        <instance x="2112" y="1264" name="XLXI_10" orien="R0" />
        <branch name="XLXN_6">
            <wire x2="2016" y1="880" y2="896" x1="2016" />
            <wire x2="2016" y1="896" y2="1008" x1="2016" />
            <wire x2="2096" y1="1008" y2="1008" x1="2016" />
            <wire x2="2112" y1="1008" y2="1008" x1="2096" />
            <wire x2="2112" y1="944" y2="944" x1="2096" />
            <wire x2="2096" y1="944" y2="1008" x1="2096" />
        </branch>
        <branch name="NOTE_CLK">
            <wire x2="2608" y1="1008" y2="1008" x1="2496" />
        </branch>
        <branch name="RESET">
            <wire x2="2112" y1="1232" y2="1232" x1="2080" />
        </branch>
        <instance x="2112" y="672" name="XLXI_11" orien="R0" />
        <branch name="XLXN_9">
            <wire x2="2016" y1="432" y2="480" x1="2016" />
            <wire x2="2112" y1="480" y2="480" x1="2016" />
        </branch>
        <branch name="CLK_50KHZ">
            <wire x2="2112" y1="544" y2="544" x1="1744" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="1824" y1="1136" y2="1136" x1="1776" />
            <wire x2="1904" y1="1136" y2="1136" x1="1824" />
            <wire x2="2112" y1="1136" y2="1136" x1="1904" />
            <wire x2="1824" y1="640" y2="976" x1="1824" />
            <wire x2="1824" y1="976" y2="1136" x1="1824" />
            <wire x2="2112" y1="640" y2="640" x1="1824" />
        </branch>
        <branch name="XLXN_14(7:0)">
            <wire x2="2592" y1="64" y2="64" x1="1120" />
            <wire x2="2592" y1="64" y2="416" x1="2592" />
            <wire x2="1120" y1="64" y2="1024" x1="1120" />
            <wire x2="1120" y1="1024" y2="1040" x1="1120" />
            <wire x2="1392" y1="1040" y2="1040" x1="1120" />
            <wire x2="2592" y1="416" y2="416" x1="2496" />
        </branch>
        <instance x="1952" y="880" name="XLXI_16" orien="R0" />
        <instance x="1952" y="432" name="XLXI_12" orien="R0" />
        <iomarker fontsize="28" x="1744" y="544" name="CLK_50KHZ" orien="R180" />
        <iomarker fontsize="28" x="2080" y="1232" name="RESET" orien="R180" />
        <iomarker fontsize="28" x="2608" y="1008" name="NOTE_CLK" orien="R0" />
    </sheet>
</drawing>