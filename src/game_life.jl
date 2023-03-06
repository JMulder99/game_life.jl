module game_life

greet() = println("Hello World, I am ThE GaMe oF lIfE!")

greet() 

using Plots
using Random

# initialize playing field
function initialize(N::Int, M::Int)
    grid = brand((N, M))
    #out = Plots.heatmap(grid, color=:greys, )
    return grid
end

# generate new generation based on older generation
function generate!(old_grid::BitMatrix)
    new_grid = bitrand(size(old_grid))
    return new_grid
end

# display current generation
function update_display(grid::BitMatrix)
    for row in eachrow(grid)
        println(join(row, "--"))
    end
end

# start and run the game iter times
function run(iters::Int)
    grid = initialize(10,10)
    update_display(grid)
    for i = 1:iters
        println("----------", i, "---------")
        grid = generate!(grid)
        #out = Plots.heatmap!(grid, color=:greys)
        #println(grid)
        #push!(out, grid)
        update_display(grid)
    end
end

run(20)
end # module game_life
