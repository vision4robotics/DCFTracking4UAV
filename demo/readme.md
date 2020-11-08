# Demo

This folder offers an example on how to implement our code library. In this case, here shows how to run AutoTrack tracker on benchmark UAV123.

1. Put AutoTrack folder in folder tracker_set

2. Download UAV123 benchmark at : https://cemse.kaust.edu.sa/ivul/uav123

3. Change the anno and sequence paths in run_all_trackers_UAV123.m here

   ```matlab
   where_is_your_groundtruth_folder = 'D:\Tracking\UAV123\anno\UAV123';        % path that containing all groundtruth files
   where_is_your_UAV123_database_folder = 'D:\Tracking\UAV123\data_seq\UAV123';       % path that containing all image sequences
   ```

4. Change the tracker's struct in trackers_info.m, *e.g.*,

   ```matlab
   info = {
       struct('AutoTrack',@run_AutoTrack),...
   };
   ```

5. Run run_all_trackers_UAV123.m

6. The results are saved as .mat files in folder ./all_trk_results/UAV123/AutoTrack

## To implement more trackers

1. Put the tracker folders that you want to run in ./tracker_set
2. Add the trackers' structs in trackers_info.m
3. Run run_all_trackers_UAV123.m.

## More details

To visualize the tracking process, in every tracker fold, please find run_XXX.m, turn on the visualize flag before running.



