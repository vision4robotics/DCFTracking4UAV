function info = trackers_info()
info = {
    struct('AutoTrack',@run_AutoTrack),...
};
%info结构体第一个字符串为tracker所在文件夹名称，亦为tracker的名称
%info结构体第二个函数句柄为tracker运行的接口, 每个tracker文件夹内都应包含该文件
          
