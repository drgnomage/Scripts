#!/usr/bin/env python3
# coding=utf-8

import LifxLAN

lifxlan = LifxLAN()
light = lifxlan.Light("D0:73:D5:26:87:E7", "172.20.0.39")

light.lifxlan.set_power_all_lights("off", rapid=True)
