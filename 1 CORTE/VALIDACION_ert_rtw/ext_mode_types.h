/*
 * ext_mode_types.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "VALIDACION".
 *
 * Model version              : 1.8
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu Sep  7 12:30:03 2023
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef EXT_MODE_TYPES_H
#define EXT_MODE_TYPES_H
#include "rtwtypes.h"

/** External Mode Event ID */
typedef uint16_T extmodeEventId_T;

/** External Mode real time, measured using the target's clock */
typedef uint32_T extmodeRealTime_T;

/** External Mode simulation time */
typedef uint32_T extmodeSimulationTime_T;

/** External Mode double data type */
typedef real_T extmodeDouble_T;

/** External Mode classic trigger signal */
typedef real_T extmodeClassicTriggerSignal_T;

/** Run the simulation forever (infinite simulation end time) */
#define EXTMODE_SIMULATION_RUN_FOREVER ((extmodeSimulationTime_T) -1)

/** External Mode MAX simulation time */
#define MAX_extmodeSimulationTime_T    MAX_uint32_T

/** External Mode MAX base rate simulation time */
#define EXTMODE_MAX_BASE_RATE_SIMULATION_TIME MAX_uint32_T

/** External Mode Step Size in microseconds */
#define EXTMODE_STEP_SIZE_IN_MICROSECONDS 10000

/** External Mode Base rate event id */
#define EXTMODE_BASE_RATE_EVENT_ID     1

/** External Mode Max Event Id */
#define EXTMODE_MAX_EVENT_ID           0xFF
#endif                                 /* EXT_MODE_TYPES_H */

/* [EOF] ext_mode_types.h */
