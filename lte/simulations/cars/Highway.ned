// 
//                           SimuLTE
// 
// This file is part of a software released under the license included in file
// "license.pdf". This license can be also found at http://www.ltesimulator.com/
// The above file and the present reference are part of the software itself, 
// and cannot be removed from it.
//
package lte.simulations.cars;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.inet.AdhocHost;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.ethernet.Eth10G;

import lte.world.radio.LteChannelControl;
import lte.epc.PgwStandardSimplified;
import lte.corenetwork.binder.LteBinder;
import lte.corenetwork.nodes.eNodeB;
import lte.corenetwork.nodes.Ue;
import lte.corenetwork.nodes.cars.Car;

import org.car2x.veins.subprojects.veins_inet.VeinsInetManager;

network Highway
{
    parameters:
        double playgroundSizeX @unit(m) = 1432m; // x size of the area the nodes are in (in meters)
        double playgroundSizeY @unit(m) = 1432m; // y size of the area the nodes are in (in meters)
        double playgroundSizeZ @unit(m) = 50m; // z size of the area the nodes are in (in meters)
        @display("bgb=1432,1432;bgg=1432,7,black");

        volatile int UeX = intuniform (0,1432);
        volatile int UeY = intuniform (0,1432);

        volatile int EnbX = intuniform (0,1432);
        volatile int EnbY = intuniform (0,1432);
    submodules:

        routingRecorder: RoutingTableRecorder {
            @display("p=50,75;is=s");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=50,125");
            config = xmldoc("demo.xml");
        }

        //# Veins manager module
//        veinsManager: VeinsInetManager {
//            @display("p=50,227;is=s");
//        }

        //# LTE modules
        channelControl: LteChannelControl {
            @display("p=50,25;is=s");
        }
        binder: LteBinder {
            @display("p=50,175;is=s");
        }
        server: StandardHost {
            @display("p=1345.223,94.2513;is=n;i=device/server");
        }
        router: Router {
            @display("p=1151.0082,91.395195;i=device/smallrouter");
        }
        pgw: PgwStandardSimplified {
            nodeType = "PGW";
            @display("p=939.65686,94.2513;is=l");
        }
        eNodeB0: eNodeB {
            @display("p=112.008,539.936;is=vl");
        }
        eNodeB1: eNodeB {
            @display("p=$EnbX,$EnbY;is=n;i=device/MovingENb");
        }
        eNodeB2: eNodeB {
            @display("p=$EnbX,$EnbY;is=n;i=device/MovingENb");
        }
        eNodeB3: eNodeB {
            @display("p=$EnbX,$EnbY;is=n;i=device/MovingENb");
        }
        eNodeB4: eNodeB {
            @display("p=$EnbX,$EnbY;is=n;i=device/MovingENb");
        }
        eNodeB5: eNodeB {
            @display("p=$EnbX,$EnbY;is=n;i=device/MovingENb");
        }
        eNodeB6: eNodeB {
            @display("p=$EnbX,$EnbY;is=n;i=device/MovingENb");
        }

        ue[200]: Ue {
            parameters:
                @display("p=$UeX,$UeY;is=s");
        }
    connections allowunconnected:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> pgw.filterGate;

        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB0.ppp;
        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB1.ppp;
        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB2.ppp;
        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB3.ppp;
        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB4.ppp;
        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB5.ppp;
        pgw.pppg++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.ppp;

        //# X2 connections
//      //eNodeB0/////////////////////////////////////////////////////////////////////////////////////////////////////  
        eNodeB0.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB1.x2++;
        eNodeB0.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB2.x2++;
        eNodeB0.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB3.x2++;
        eNodeB0.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB4.x2++;
        eNodeB0.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB5.x2++;
        eNodeB0.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.x2++;
//      //eNodeB1/////////////////////////////////////////////////////////////////////////////////////////////////////  
        eNodeB1.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB2.x2++;
        eNodeB1.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB3.x2++;
        eNodeB1.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB4.x2++;
        eNodeB1.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB5.x2++;
        eNodeB1.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.x2++;
//      //eNodeB2/////////////////////////////////////////////////////////////////////////////////////////////////////  
        eNodeB2.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB3.x2++;
        eNodeB2.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB4.x2++;
        eNodeB2.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB5.x2++;
        eNodeB2.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.x2++;
//      //eNodeB3/////////////////////////////////////////////////////////////////////////////////////////////////////  
        eNodeB3.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB4.x2++;
        eNodeB3.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB5.x2++;
        eNodeB3.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.x2++;
//      //eNodeB4/////////////////////////////////////////////////////////////////////////////////////////////////////  
        eNodeB4.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB5.x2++;
        eNodeB4.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.x2++;
//      //eNodeB5/////////////////////////////////////////////////////////////////////////////////////////////////////
        eNodeB5.x2++ <--> Eth10G { @display("ls=grey83"); } <--> eNodeB6.x2++;
}

