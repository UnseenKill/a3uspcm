#ifndef __UIB__SCRIPT_MACROS_HPP__
#define __UIB__SCRIPT_MACROS_HPP__

// Export-safe macros for the UI Builder plugin

#define UIB_CONSTANT_PREFIX DOUBLES(A3USPCM,UIB)
#define UIBVAR(var1) DOUBLES(UIB_CONSTANT_PREFIX,var1)
#define QUIBVAR(var1) QUOTE(UIBVAR(var1))

#endif // __UIB__SCRIPT_MACROS_HPP__
