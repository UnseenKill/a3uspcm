#define DISASM_INFO_PATCH(from,to) \
    class from: B_UAV_01_F { \
        class assembleInfo { \
            assembleTo = ""; \
            base = ""; \
            displayName = ""; \
            dissasembleTo[] = { QUOTE(to) }; \
            primary = 1; \
        }; \
    }

class CfgVehicles {
    class B_UAV_01_F;

    DISASM_INFO_PATCH(WNZ_AR81_Wasp_B,B_WNZ_AR81_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR81_Wasp_O,O_WNZ_AR81_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR81_Wasp_O_T,O_T_WNZ_AR81_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR81_Wasp_I,I_WNZ_AR81_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR81_Wasp_I_E,I_E_WNZ_AR81_backpack_F);

    DISASM_INFO_PATCH(WNZ_AR85_Wasp_B,B_WNZ_AR85_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR85_Wasp_O,O_WNZ_AR85_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR85_Wasp_O_T,O_T_WNZ_AR85_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR85_Wasp_I,I_WNZ_AR85_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR85_Wasp_I_E,I_E_WNZ_AR85_backpack_F);

    DISASM_INFO_PATCH(WNZ_AR86_Wasp_B,B_WNZ_AR86_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR86_Wasp_O,O_WNZ_AR86_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR86_Wasp_O_T,O_T_WNZ_AR86_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR86_Wasp_I,I_WNZ_AR86_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR86_Wasp_I_E,I_E_WNZ_AR86_backpack_F);

    DISASM_INFO_PATCH(WNZ_AR87_Wasp_B,B_WNZ_AR87_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR87_Wasp_O,O_WNZ_AR87_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR87_Wasp_O_T,O_T_WNZ_AR87_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR87_Wasp_I,I_WNZ_AR87_backpack_F);
    DISASM_INFO_PATCH(WNZ_AR87_Wasp_I_E,I_E_WNZ_AR87_backpack_F);
};
