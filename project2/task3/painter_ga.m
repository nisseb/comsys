% Genetic algorithm for evolving a good floor painter

%% Parameters

pop_size = 50; % should be even number
generations = 100;
mutate_prob = 0.002;
cross_prob = 1;
sample_n = 5;   % how many times to calculate fitness for each

%% Initial setup

chromos = randi(4, pop_size, 54) - 1;
room = zeros(20, 40);
room = room2;
fitness = zeros(generations+1, pop_size);

%% Evolve

for g=1:generations
    disp(['Generation: ' num2str(g)])
    
    % calculate fitness for each chromosome
    % by running the painter_play function
    % sample_n number of times and averaging the score
    for k=1:pop_size    
        scores = zeros(sample_n, 1);
        
        for i=1:sample_n
            [scores(i), ~, ~] = painter_play(chromos(k,:), room);
        end
        
        fitness(g, k) = mean(scores);
    end
    
    % choose pop_size chromosomes at random weighed by their fitness
    selected = randsample(pop_size, pop_size, true, fitness(g,:));
    new_chromos = zeros(pop_size, 54);
    
    % do the cross over and get the new generation
    for k=1:2:pop_size
        [c1, c2] = sp_crossover(chromos(selected(k),:), ... 
                                chromos(selected(k+1),:), ...
                                cross_prob);
        new_chromos(k, :) = c1;
        new_chromos(k+1,:) = c2;
    end
    
    % update the new generation
    chromos = new_chromos;
    
    % do random mutations with probability mutate_prob per locus
    for k=1:pop_size*54
       if (rand < mutate_prob)
          chromos(k) = randi(4)-1;
       end
    end
    
end

% Calculate scores again and get the best one
for k=1:pop_size    
   	scores = zeros(sample_n, 1);
        
    for i=1:sample_n
       	[scores(i), ~, ~] = painter_play(chromos(k,:), room);
    end
        
    fitness(end, k) = mean(scores);
end

[best_score, best_i] = max(fitness(end, :));
best_chromo = chromos(best_i, :);
disp(['Best average score: ' num2str(best_score)])

figure(1)
plot(mean(fitness, 2))
xlabel('Generation')
ylabel('Average population fitness')

figure(2)
colormap copper
imagesc(chromos)
xlabel('locus point')
ylabel('chromosome number')
