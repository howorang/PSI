%config
number_of_cities = 8;
start_city = 1;
dest_city = 4;
offspring =@(current_node, cities) offspring_naive(current_node, cities);

%consts
boundry = 10;

for i = 1: number_of_cities
    cities(i).number = i;
    cities(i).x = rand() * boundry;
    cities(i).y = rand() * boundry;
end

%preparing initial state
state.nodes(1).path(1) = start_city;
state.nodes(1).cost = 0;
state.nodes(1).heuristic = 0;
state.nodes_to_check_ptr = 1;
state.done = [];
state.nodes_to_check = state.nodes; %is a fokin stack

while state.nodes_to_check_ptr ~= 0
     [node, state] = pop_node(state);
     new_nodes = offspring(node, cities);
     if size(new_nodes(1).path) ~= number_of_cities + 1
        state = push_node(new_nodes, state);
     else
         if size(state.done) == 0
            best = new_nodes;
         else
             if new_nodes.cost < best.cost
                 best = new_nodes;
             end
         end
         state.done = [state.done, new_nodes];
     end
end