include $(TOPDIR)/rules.mk

PKG_NAME:=overture
PKG_VERSION:=1.7-rc2
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://github.com/shawn1m/overture/archive/v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/shawn1m/overture/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=19dc94fbddcbbe1c580bf7af6d0f385b9d9576ecd8cbadee0c726f630e34e08e

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/shawn1m/overture
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:=main.version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/overture
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=A customized DNS forwarder written in Go
  URL:=https://github.com/shawn1m/overture
endef

define Package/overture/description
  Overture is a DNS server/forwarder/dispatcher written in Go.
  Overture means an orchestral piece at the beginning of a classical music composition, just like DNS which is nearly the first step of surfing the Internet.
endef

define Package/overture/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/sbin/overture
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/overture.init $(1)/etc/init.d/overture
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/overture.config $(1)/etc/config/overture
	$(INSTALL_DIR) $(1)/etc/overture
	$(INSTALL_CONF) ./files/overture/* $(1)/etc/overture/
endef

$(eval $(call GoBinPackage,overture))
$(eval $(call BuildPackage,overture))
