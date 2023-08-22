#include <android/log.h>

#ifndef __COMM_LOG_H__
#define __COMM_LOG_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define filename(x) strrchr(x,'/')?strrchr(x,'/')+1:x
#define __FILENAME__ filename(__FILE__)
#define DBG(fmt, args...) printf("%s:%d:%s() " fmt "\n", filename(__FILE__) , __LINE__, __func__, ##args)


#define MAX_PRINT_PRIORITY 8 //打印最大的优先级(0:异常信息，必须显示;  2：重要信息，可以显示;   5：一般信息，调试过程中显示。 8:for循环内部数据，一般不需要显示)

#define LOG_TAG "pccall"
#define ALOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define ALOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

#endif
