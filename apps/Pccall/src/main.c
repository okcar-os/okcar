#include "main.h"

extern int optind, opterr, optopt;
extern char *optarg;

// int get_device_model(char *device_model, size_t buffer_size) {
//     FILE *fp;
//     const char *command = "getprop ro.product.bootimage.device";

//     fp = popen(command, "r");
//     if (fp == NULL) {
//         printf("Failed to execute command\n");
//         return 1;
//     }

//     fgets(device_model, buffer_size - 1, fp);
//     fclose(fp);

//     // Remove trailing newline character
//     device_model[strcspn(device_model, "\n")] = 0;

//     return 0;
// }

char param[64];
int main(int argc, char *argv[])
{
    int c = 0; // 用于接收选项
    /*循环处理参数*/
    while (EOF != (c = getopt(argc, argv, "i:b:l:")))
    {
        switch (c)
        {
        case 'b':
            bootWhenCharge(atoi(optarg));
            break;
        case 'i':
            ipRuleConfig(atoi(optarg));
            break;
        case 'l':
            // pccall -l 0 将dmesg日志写入到/sdcard/dmesg.txt
            dmesg();
            break;
        //表示选项不支持
        case '?':
            ALOGI("unknow option:%c\n", optopt);
            break;
        default:
            break;
        }
    }
    return 0;
}

void dmesg()
{
    system("dmesg > /sdcard/dmesg.txt");
}


int readFileContentAsInt(const char *filePath) {
    FILE *file;
    int value = 0;

    file = fopen(filePath, "r");
    if (file == NULL) {
        perror("Error opening file");
        return -1;
    }

    if (fscanf(file, "%d", &value) != 1) {
        fclose(file);
        return -1;
    }

    fclose(file);
    return value;
}

void bootWhenCharge(int b) {
    if (b == 1) {
        struct stat statbuf;

        // Some devices do not have a metadata partition; these devices boot up automatically by default.
        if (stat("/metadata/bootstat", &statbuf) == 0 && S_ISDIR(statbuf.st_mode)) {
            if (readFileContentAsInt("/metadata/bootstat/charger_wake_enable") != 1) {
                return;
            }
            int chargerWakeTime = readFileContentAsInt("/metadata/bootstat/charger_wake_time");
            if (chargerWakeTime < 0) {
                chargerWakeTime = 0;
            }
            if (chargerWakeTime > 0) {
                usleep(chargerWakeTime * 1000);
                ALOGI("Sleep For: %dms\n", chargerWakeTime);
            }
        }        
        // OnePlus9 can't read /sys/class/power_supply/usb/online
        // int isCharging = readFileContentAsInt("/sys/class/power_supply/usb/online");
        // ALOGI("Device is charging %d\n", isCharging);
        // if (isCharging != 1) {
        //     return;
        // }
        system("setprop sys.powerctl reboot");
    }
}

void ipRuleConfig(int b)
{
    if (b == 1)
    {
        system("ip -6 route add fe80::/64 dev usb0 metric 256");
        system("ip -6 rule add from all lookup main pref 10400");
    }
}