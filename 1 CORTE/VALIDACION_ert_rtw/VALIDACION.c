/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: VALIDACION.c
 *
 * Code generated for Simulink model 'VALIDACION'.
 *
 * Model version                  : 1.8
 * Simulink Coder version         : 9.6 (R2021b) 14-May-2021
 * C/C++ source code generated on : Thu Sep  7 12:30:03 2023
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "VALIDACION.h"
#include "VALIDACION_private.h"

/* Block signals (default storage) */
B_VALIDACION_T VALIDACION_B;

/* Continuous states */
X_VALIDACION_T VALIDACION_X;

/* Block states (default storage) */
DW_VALIDACION_T VALIDACION_DW;

/* Real-time model */
static RT_MODEL_VALIDACION_T VALIDACION_M_;
RT_MODEL_VALIDACION_T *const VALIDACION_M = &VALIDACION_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 1;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  VALIDACION_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  VALIDACION_step();
  VALIDACION_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  VALIDACION_step();
  VALIDACION_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void VALIDACION_step(void)
{
  codertarget_arduinobase_inter_T *obj;
  real_T tmp;
  real_T tmp_0;
  real_T tmp_1;
  int16_T rtb_Gain1;
  uint16_T rtb_AnalogInput_0;
  uint8_T SwappedDataBytes[2];
  uint8_T b_x[2];
  if (rtmIsMajorTimeStep(VALIDACION_M)) {
    /* set solver stop time */
    rtsiSetSolverStopTime(&VALIDACION_M->solverInfo,
                          ((VALIDACION_M->Timing.clockTick0+1)*
      VALIDACION_M->Timing.stepSize0));
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(VALIDACION_M)) {
    VALIDACION_M->Timing.t[0] = rtsiGetT(&VALIDACION_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(VALIDACION_M)) {
    /* Step: '<S2>/Step' incorporates:
     *  Step: '<S2>/Step1'
     *  Step: '<S2>/Step2'
     */
    tmp_1 = ((VALIDACION_M->Timing.clockTick1) * 0.01);
    if (tmp_1 < VALIDACION_P.Step_Time) {
      tmp = VALIDACION_P.Step_Y0;
    } else {
      tmp = VALIDACION_P.Step_YFinal;
    }

    /* End of Step: '<S2>/Step' */

    /* Step: '<S2>/Step1' */
    if (tmp_1 < VALIDACION_P.Step1_Time) {
      tmp_0 = VALIDACION_P.Step1_Y0;
    } else {
      tmp_0 = VALIDACION_P.Step1_YFinal;
    }

    /* Step: '<S2>/Step2' */
    if (tmp_1 < VALIDACION_P.Step2_Time) {
      tmp_1 = VALIDACION_P.Step2_Y0;
    } else {
      tmp_1 = VALIDACION_P.Step2_YFinal;
    }

    /* Sum: '<S2>/Sum' */
    VALIDACION_B.Sum = (tmp + tmp_0) - tmp_1;

    /* Gain: '<Root>/Gain1' */
    tmp_1 = floor(VALIDACION_P.Gain1_Gain * VALIDACION_B.Sum);
    if (rtIsNaN(tmp_1) || rtIsInf(tmp_1)) {
      tmp_1 = 0.0;
    } else {
      tmp_1 = fmod(tmp_1, 65536.0);
    }

    rtb_Gain1 = tmp_1 < 0.0 ? -(int16_T)(uint16_T)-tmp_1 : (int16_T)(uint16_T)
      tmp_1;

    /* End of Gain: '<Root>/Gain1' */

    /* MATLABSystem: '<Root>/I2C Write' */
    memcpy((void *)&SwappedDataBytes[0], (void *)&rtb_Gain1, (uint16_T)((size_t)
            2 * sizeof(uint8_T)));
    b_x[0] = SwappedDataBytes[1];
    b_x[1] = SwappedDataBytes[0];
    memcpy((void *)&rtb_Gain1, (void *)&b_x[0], (uint16_T)((size_t)1 * sizeof
            (int16_T)));
    memcpy((void *)&SwappedDataBytes[0], (void *)&rtb_Gain1, (uint16_T)((size_t)
            2 * sizeof(uint8_T)));
    MW_I2C_MasterWrite(VALIDACION_DW.obj_b.I2CDriverObj.MW_I2C_HANDLE, 96UL,
                       &SwappedDataBytes[0], 2UL, false, false);

    /* MATLABSystem: '<Root>/Analog Input' */
    if (VALIDACION_DW.obj.SampleTime != VALIDACION_P.AnalogInput_SampleTime) {
      VALIDACION_DW.obj.SampleTime = VALIDACION_P.AnalogInput_SampleTime;
    }

    obj = &VALIDACION_DW.obj;
    obj->AnalogInDriverObj.MW_ANALOGIN_HANDLE = MW_AnalogIn_GetHandle(14UL);
    MW_AnalogInSingle_ReadResult
      (VALIDACION_DW.obj.AnalogInDriverObj.MW_ANALOGIN_HANDLE,
       &rtb_AnalogInput_0, 3);

    /* Gain: '<Root>/Gain' incorporates:
     *  MATLABSystem: '<Root>/Analog Input'
     */
    VALIDACION_B.SALIDA = (uint32_T)VALIDACION_P.Gain_Gain * rtb_AnalogInput_0;
  }

  /* TransferFcn: '<Root>/Transfer Fcn' */
  VALIDACION_B.FUNCIONDETRANSFERENCIA = 0.0;
  VALIDACION_B.FUNCIONDETRANSFERENCIA += VALIDACION_P.TransferFcn_C *
    VALIDACION_X.TransferFcn_CSTATE;
  if (rtmIsMajorTimeStep(VALIDACION_M)) {
  }

  if (rtmIsMajorTimeStep(VALIDACION_M)) {
    {                                  /* Sample time: [0.0s, 0.0s] */
      extmodeErrorCode_T errorCode = EXTMODE_SUCCESS;
      extmodeSimulationTime_T currentTime = (extmodeSimulationTime_T)
        ((VALIDACION_M->Timing.clockTick0 * 1) + 0)
        ;

      /* Trigger External Mode event */
      errorCode = extmodeEvent(0,currentTime);
      if (errorCode != EXTMODE_SUCCESS) {
        /* Code to handle External Mode event errors
           may be added here */
      }
    }

    if (rtmIsMajorTimeStep(VALIDACION_M)) {/* Sample time: [0.01s, 0.0s] */
      extmodeErrorCode_T errorCode = EXTMODE_SUCCESS;
      extmodeSimulationTime_T currentTime = (extmodeSimulationTime_T)
        ((VALIDACION_M->Timing.clockTick1 * 1) + 0)
        ;

      /* Trigger External Mode event */
      errorCode = extmodeEvent(1,currentTime);
      if (errorCode != EXTMODE_SUCCESS) {
        /* Code to handle External Mode event errors
           may be added here */
      }
    }
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(VALIDACION_M)) {
    rt_ertODEUpdateContinuousStates(&VALIDACION_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     */
    ++VALIDACION_M->Timing.clockTick0;
    VALIDACION_M->Timing.t[0] = rtsiGetSolverStopTime(&VALIDACION_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.01s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.01, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       */
      VALIDACION_M->Timing.clockTick1++;
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void VALIDACION_derivatives(void)
{
  XDot_VALIDACION_T *_rtXdot;
  _rtXdot = ((XDot_VALIDACION_T *) VALIDACION_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE = 0.0;
  _rtXdot->TransferFcn_CSTATE += VALIDACION_P.TransferFcn_A *
    VALIDACION_X.TransferFcn_CSTATE;
  _rtXdot->TransferFcn_CSTATE += VALIDACION_B.Sum;
}

/* Model initialize function */
void VALIDACION_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&VALIDACION_M->solverInfo,
                          &VALIDACION_M->Timing.simTimeStep);
    rtsiSetTPtr(&VALIDACION_M->solverInfo, &rtmGetTPtr(VALIDACION_M));
    rtsiSetStepSizePtr(&VALIDACION_M->solverInfo,
                       &VALIDACION_M->Timing.stepSize0);
    rtsiSetdXPtr(&VALIDACION_M->solverInfo, &VALIDACION_M->derivs);
    rtsiSetContStatesPtr(&VALIDACION_M->solverInfo, (real_T **)
                         &VALIDACION_M->contStates);
    rtsiSetNumContStatesPtr(&VALIDACION_M->solverInfo,
      &VALIDACION_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&VALIDACION_M->solverInfo,
      &VALIDACION_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&VALIDACION_M->solverInfo,
      &VALIDACION_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&VALIDACION_M->solverInfo,
      &VALIDACION_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&VALIDACION_M->solverInfo, (&rtmGetErrorStatus
      (VALIDACION_M)));
    rtsiSetRTModelPtr(&VALIDACION_M->solverInfo, VALIDACION_M);
  }

  rtsiSetSimTimeStep(&VALIDACION_M->solverInfo, MAJOR_TIME_STEP);
  VALIDACION_M->intgData.y = VALIDACION_M->odeY;
  VALIDACION_M->intgData.f[0] = VALIDACION_M->odeF[0];
  VALIDACION_M->intgData.f[1] = VALIDACION_M->odeF[1];
  VALIDACION_M->intgData.f[2] = VALIDACION_M->odeF[2];
  VALIDACION_M->contStates = ((X_VALIDACION_T *) &VALIDACION_X);
  rtsiSetSolverData(&VALIDACION_M->solverInfo, (void *)&VALIDACION_M->intgData);
  rtsiSetSolverName(&VALIDACION_M->solverInfo,"ode3");
  rtmSetTPtr(VALIDACION_M, &VALIDACION_M->Timing.tArray[0]);
  rtmSetTFinal(VALIDACION_M, 40.0);
  VALIDACION_M->Timing.stepSize0 = 0.01;

  /* External mode info */
  VALIDACION_M->Sizes.checksums[0] = (2094754440U);
  VALIDACION_M->Sizes.checksums[1] = (729324266U);
  VALIDACION_M->Sizes.checksums[2] = (1757890107U);
  VALIDACION_M->Sizes.checksums[3] = (1530182265U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[3];
    VALIDACION_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(VALIDACION_M->extModeInfo,
      &VALIDACION_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(VALIDACION_M->extModeInfo, VALIDACION_M->Sizes.checksums);
    rteiSetTPtr(VALIDACION_M->extModeInfo, rtmGetTPtr(VALIDACION_M));
  }

  {
    uint32_T i2cname;
    codertarget_arduinobase_int_i_T *obj;
    codertarget_arduinobase_inter_T *obj_0;
    uint32_T varargin_1;

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
    VALIDACION_X.TransferFcn_CSTATE = 0.0;

    /* Start for MATLABSystem: '<Root>/I2C Write' */
    VALIDACION_DW.obj_b.matlabCodegenIsDeleted = true;
    VALIDACION_DW.obj_b.DefaultMaximumBusSpeedInHz = 400000.0;
    VALIDACION_DW.obj_b.isInitialized = 0L;
    VALIDACION_DW.obj_b.I2CDriverObj.MW_I2C_HANDLE = NULL;
    VALIDACION_DW.obj_b.matlabCodegenIsDeleted = false;
    obj = &VALIDACION_DW.obj_b;
    VALIDACION_DW.obj_b.isSetupComplete = false;
    VALIDACION_DW.obj_b.isInitialized = 1L;
    i2cname = 0;
    obj->I2CDriverObj.MW_I2C_HANDLE = MW_I2C_Open(i2cname, 0);
    VALIDACION_DW.obj_b.BusSpeed = 100000UL;
    varargin_1 = VALIDACION_DW.obj_b.BusSpeed;
    MW_I2C_SetBusSpeed(VALIDACION_DW.obj_b.I2CDriverObj.MW_I2C_HANDLE,
                       varargin_1);
    VALIDACION_DW.obj_b.isSetupComplete = true;

    /* Start for MATLABSystem: '<Root>/Analog Input' */
    VALIDACION_DW.obj.matlabCodegenIsDeleted = true;
    VALIDACION_DW.obj.isInitialized = 0L;
    VALIDACION_DW.obj.SampleTime = -1.0;
    VALIDACION_DW.obj.matlabCodegenIsDeleted = false;
    VALIDACION_DW.obj.SampleTime = VALIDACION_P.AnalogInput_SampleTime;
    obj_0 = &VALIDACION_DW.obj;
    VALIDACION_DW.obj.isSetupComplete = false;
    VALIDACION_DW.obj.isInitialized = 1L;
    obj_0->AnalogInDriverObj.MW_ANALOGIN_HANDLE = MW_AnalogInSingle_Open(14UL);
    VALIDACION_DW.obj.isSetupComplete = true;
  }
}

/* Model terminate function */
void VALIDACION_terminate(void)
{
  codertarget_arduinobase_inter_T *obj;

  /* Terminate for MATLABSystem: '<Root>/I2C Write' */
  if (!VALIDACION_DW.obj_b.matlabCodegenIsDeleted) {
    VALIDACION_DW.obj_b.matlabCodegenIsDeleted = true;
    if ((VALIDACION_DW.obj_b.isInitialized == 1L) &&
        VALIDACION_DW.obj_b.isSetupComplete) {
      MW_I2C_Close(VALIDACION_DW.obj_b.I2CDriverObj.MW_I2C_HANDLE);
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/I2C Write' */

  /* Terminate for MATLABSystem: '<Root>/Analog Input' */
  obj = &VALIDACION_DW.obj;
  if (!VALIDACION_DW.obj.matlabCodegenIsDeleted) {
    VALIDACION_DW.obj.matlabCodegenIsDeleted = true;
    if ((VALIDACION_DW.obj.isInitialized == 1L) &&
        VALIDACION_DW.obj.isSetupComplete) {
      obj->AnalogInDriverObj.MW_ANALOGIN_HANDLE = MW_AnalogIn_GetHandle(14UL);
      MW_AnalogIn_Close(VALIDACION_DW.obj.AnalogInDriverObj.MW_ANALOGIN_HANDLE);
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/Analog Input' */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
