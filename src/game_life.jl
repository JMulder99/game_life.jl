module game_life

greet() = println("Hello World, I am ThE GaMe oF lIfE!")

greet() 

# using Plots
using Random
using GLMakie 

# initialize playing field
function init_grid(N::Int, M::Int)
    grid = bitrand((N, M))
    return grid
end


function count_neighbours(grid::BitMatrix, x::Int64, y::Int64)
    sum = 0
    s = size(grid)
    for i ∈ -1:1, j ∈ -1:1
        if 1 <= x+i <= s[1] && 1 <= y+j < s[2]
            if grid[x+i, y+j] == 1
                sum += 1
            end
        end
    end
    return sum
end

# generate new generation based on older generation
function generate!(old_grid::BitMatrix)
    #new_grid = bitrand(size(old_grid))
    s = size(old_grid)
    new_grid = BitArray(undef, s)

    # check all grid cells -> can be optimized
    for i ∈ 1:s[1], j ∈ 1:s[2]
        life_neighs = count_neighbours(old_grid, i, j)
        
        # these are the rules that determine which cells goes on living the next generation
        if life_neighs == 3
            new_grid[i, j] = 1
        elseif old_grid[i, j] == 1 && life_neighs == 2
            new_grid[i, j] = 1
        end
    end
    return new_grid
end

# display current generation in command line
function update_cli(grid::BitMatrix)
    for row in eachrow(grid)
        for item in row
            if item == true
                print("1-")
            else
                print("0-")
            end
        end
        println()
        println(repeat('-', 2*length(row)))
    end
end

# display current generation in heatmap
function update_heatmap(hm, grid::BitMatrix)
    hm[3] = grid
    return hm
end

# start and run the game iter times
function run(iters::Int, N::Int, M::Int)
    grid = init_grid(N, M)
    fig, ax, hm = GLMakie.heatmap(1:N, 1:M, grid, color=:greys, )
    display(fig)
    for i = 1:iters
        #println("----------", i, "---------")
        grid = generate!(grid)
        #println(grid)
        hm[3] = grid
        yield()
        sleep(1/60) 
    end
end

#time_run(N) = @time run(1);

run(100, 1000, 100)
end # module game_life
