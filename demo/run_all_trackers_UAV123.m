 % LBW  2020/11/8

function run_all_trackers_UAV123()                                       
%%  read sequences and groundtruth
where_is_your_groundtruth_folder = 'D:\Tracking\UAV123\anno\UAV123';        % path that containing all groundtruth files
where_is_your_UAV123_database_folder = 'D:\Tracking\UAV123\data_seq\UAV123';       % path that containing all image sequences

tpye_of_assessment = 'UAV123';         

%% Read all video names using grouthtruth.txt
type = tpye_of_assessment;
ground_truth_folder = where_is_your_groundtruth_folder;
dir_output = dir(fullfile(ground_truth_folder, '\*.txt'));             
contents = {dir_output.name}';  
all_video_name = cell(numel(contents),1);
for k = 1:numel(contents)
    name = contents{k}(1:end-4);                                       
    all_video_name{k,1} = name;                                    
end
dataset_num = length(all_video_name);                                  
main_folder = pwd;                                                    
all_trackers_dir = '.\tracker_set\';                                

save_dir = [main_folder '\all_trk_results\UAV123\'];            

run_trackers_info = trackers_info();                                   
tracker_name_set=cell(length(run_trackers_info),1);
for g=1:length(run_trackers_info)
    tracker_name_set(g) = fieldnames(run_trackers_info{g});                     
end
tracker_num = length(tracker_name_set);                               
cd(all_trackers_dir);                                                 
%%
for tracker_count = 1: tracker_num
    tracker_name = tracker_name_set{tracker_count};
    addpath(genpath(tracker_name));                                  
    cd(tracker_name);                                                
    save_res_dir = [save_dir, tracker_name,'\']; 
    save_pic_dir = [save_res_dir, 'res_picture\'];               
    if ~exist(save_res_dir, 'dir')
        mkdir(save_res_dir);
        mkdir(save_pic_dir);
    end
    
    for dataset_count=1:dataset_num
        video_name = all_video_name{dataset_count};           
        database_folder = where_is_your_UAV123_database_folder;
        seq = load_video_info_UAV123(video_name, database_folder, ground_truth_folder, type);
 
        assignin('base','subS',seq);                                   
       
        % main function
        run_tracker = getfield(run_trackers_info{tracker_count}, tracker_name_set{tracker_count}); 
        fprintf('run %s on %d %s ', tracker_name, dataset_count, video_name);
        result = run_tracker(seq);             
     
        % save results
        results = cell(1,1);                                          
        results{1}=result;
        results{1}.len = seq.len;
        results{1}.annoBegin = seq.st_frame;
        results{1}.startFrame = seq.st_frame;
        fprintf('fps: %f\n', results{1}.fps);
        
        save([save_res_dir, video_name, '_', tracker_name,'.mat']);
        % plot precision figure
        show_visualization =false;                                     
        precision_plot_save(results{1}.res, seq.ground_truth, video_name, save_pic_dir, show_visualization);
        close all;
    end
    cd ..;                                                      
    rmpath(genpath(tracker_name));                                   
end

