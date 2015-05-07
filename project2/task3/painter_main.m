
% Initial data and allocation
num_chroms = 50;
chromlen = 54;
samples = 5;
gens = 200;
Pcross = 1;
Pmut = 0.002;

chroms = randi([0 3], [num_chroms,chromlen]);
room = zeros(20,40);
res = zeros(num_chroms,samples);

% Data
avg_fit = zeros(num_chroms, gens);
matings = 0;
mutations = 0;

wh = waitbar(0,'');

time = 0;

for k=1:gens
    
    t = cputime;
    
    seconds = round((gens-k+1)*time);
    perc = (k-1)/gens;
    min = floor(seconds/60);
    secs = mod(seconds,min);
    
    wait_msg = sprintf('%0.2f%% Complete, %d minutes and %d seconds left', ...
                       perc*100, min, secs);
    waitbar(k/gens, wh, wait_msg);
    
    % Generate results for several tries on painter_play
    for j=1:samples
        for i=1:num_chroms
            res(i,j) = painter_play( chroms(i,:) , room );
        end
    end
    
    % Calculate average fitness for each chromosome
    avg_eff = mean(res');
    fitness = cumsum(avg_eff)./sum(avg_eff);
    
    % Save data
    avg_fit(:,k) = avg_eff';
    
    % Mating process
    nextgen_chroms = [];
    for ii=1:num_chroms/2;
        
        % Make sure it cannot mate with itself
        chrompos1 = 1;
        chrompos2 = 1;
        while (chrompos1 == chrompos2)
            rand_chrom = rand(1,2);
            chrompos1 = find(fitness-rand_chrom(1) > 0 , 1, 'first');
            chrompos2 = find(fitness-rand_chrom(2) > 0 , 1, 'first');
        end

        if (rand < Pcross)
            loc = randi([1 chromlen-1]);
            chrom1 = [chroms(chrompos1,1:loc) chroms(chrompos2,loc+1:end)];
            chrom2 = [chroms(chrompos2,1:loc) chroms(chrompos1,loc+1:end)];
            matings = matings + 1;
        else
            chrom1 = chroms(chrompos1,:);
            chrom2 = chroms(chrompos2,:);
        end
        
        %chroms(chrompos1,:) = [];
        %chroms(chrompos2,:) = [];
        nextgen_chroms = [nextgen_chroms; chrom1; chrom2];
        
    end
    
    % Random mutations
    for ii=1:num_chroms
        for jj=1:chromlen
            
            if rand < Pmut
                nextgen_chroms(ii,jj) = randi([0 3]);
                mutations = mutations + 1;
            end
        end 
    end
    
    chroms = nextgen_chroms;
    %plot(fitness);
    
    time = cputime - t;
end

% Plot path

PATH_PLOT = 1;
if PATH_PLOT
    best_chrom_pos = find(avg_fit(:,end) == max(avg_fit(:,end)));
    best_chrom = chroms(22,:);
    [res, x, y] = painter_play(best_chrom,room);
    res
    path_show(x,y,room);
end

% Chromosome plot

CHROM_PLOT = 1;
if CHROM_PLOT
    imagesc(chroms);
end

close(wh);

mean_fit = mean(avg_fit);
maxfit = max(avg_fit(:,end));

figure(3);
plot(mean_fit);



