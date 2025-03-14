#define A3U_STORE_MAGAZINE_STOCK 200
#define A3U_STORE_LAUNCHER_STOCK 15
#define A3U_STORE_PISTOL_STOCK 50
#define A3U_STORE_RIFLE_STOCK 20
#define A3U_STORE_MZ_STOCK 50
#define A3U_STORE_NN_STOCK 50
#define A3U_STORE_PN_STOCK 25
#define A3U_STORE_MISC_STOCK 50

#define A3U_STORE_DEFITEM(iClassName,iPrice,iStock) \
	class iClassName { \
		price = iPrice; \
		stock = iStock; \
	}
