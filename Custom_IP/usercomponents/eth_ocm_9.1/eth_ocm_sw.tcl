#
# eth_ocm_sw.tcl
#

# Create a new driver
create_driver eth_ocm_driver

# Associate it with some hardware known as "eth_ocm"
set_sw_property hw_class_name eth_ocm 

# The version of this driver is "9.1"
set_sw_property version 9.1

# This driver may be incompatible with versions of hardware less
# than specified below. Updates to hardware and device drivers
# rendering the driver incompatible with older versions of
# hardware are noted with this property assignment.
#
# Multiple-Version compatibility was introduced in version 7.1;
# prior versions are therefore excluded.
set_sw_property min_compatible_hw_version 9.1

# Initialize the driver in alt_sys_init()
set_sw_property auto_initialize true

# Location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory drivers

#
# Source file listings...
#

# C/C++ source files
add_sw_property c_source HAL/src/ins_eth_ocm.c
add_sw_property c_source HAL/src/eth_ocm_phy.c
add_sw_property c_source HAL/src/eth_ocm_phy_profiles.c

# Include files
add_sw_property include_source HAL/inc/eth_ocm.h
add_sw_property include_source HAL/inc/ins_eth_ocm.h
add_sw_property include_source HAL/inc/eth_ocm_phy.h
add_sw_property include_source HAL/inc/eth_ocm_desc.h
add_sw_property include_source inc/eth_ocm_regs.h

# This driver supports HAL & UCOSII BSP (OS) types
add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII

# Add the following per_driver configuration option to the BSP:
#  o Type of setting (boolean_define_only translates to "either
#    emit a #define if true, or don't if false"). Useful for
#    source code with "#ifdef" style build-options.
#  o Generated file to write to (public_mk_define -> public.mk)
#  o Name of setting for use with bsp command line settings tools
#    (enable_small_driver). This name will be combined with the
#    driver class to form a settings hierarchy to assure unique
#    settings names
#  o '#define' in driver code (and therefore string in generated
#     makefile): "ALTERA_TRIPLE_SPEED_MAC", which means: "emit
#     CPPFLAGS += ALTERA_TRIPLE_SPEED_MAC in generated makefile
#  o Default value (if the user doesn't specify at BSP creation): true
#    (which means: 'emit above CPPFLAGS string in generated makefile)
#  o Description text
add_sw_setting boolean_define_only public_mk_define enable_uncached_packets ALTERA_TRIPLE_SPEED_MAC true "Enable uncached packet allocation for InterNiche Stack"

add_sw_setting decimal_number      public_mk_define max_supported_phy_profiles ETH_OCM_PHY_MAX_PROFILES 3 "Maximum number of PHY profiles to support"
add_sw_setting boolean_define_only public_mk_define support_lxt972a         ETH_OCM_PHY_SUPPORT_LXT972A false "Enable support for Intel LXT972A PHY profile"
add_sw_setting boolean_define_only public_mk_define support_mvl88e1111      ETH_OCM_PHY_SUPPORT_MVL88E1111 true "Enable support for Marvell 88E1111 PHY profile"
add_sw_setting boolean_define_only public_mk_define support_dp83848c        ETH_OCM_PHY_SUPPORT_DP83848C true "Enable support for National DP83848C PHY profile"
add_sw_setting boolean_define_only public_mk_define support_vsc8641         ETH_OCM_PHY_SUPPORT_VSC8641 false "Enable support for Intel VSC8641 PHY profile"


# End of file
