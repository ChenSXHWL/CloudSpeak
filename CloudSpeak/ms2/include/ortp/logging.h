
#ifndef ORTP_LOGGING_H
#define ORTP_LOGGING_H


//#include "model.h"
#include <ortp/port.h>



#ifdef __cplusplus
extern "C"
{
#endif

#define ortp_debug				RTP_LOGD
#define ortp_message			RTP_LOGI
#define ortp_warning			RTP_LOGW
#define ortp_error				RTP_LOGE
#define ortp_fatal				RTP_LOGF



#ifdef __cplusplus
}
#endif

#endif
