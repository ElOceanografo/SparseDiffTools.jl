"""
        greedy_star1_coloring

    Find a coloring of a given input graph such that
    no two vertices connected by an edge have the same
    color using greedy approach. The number of colors
    used may be equal or greater than the chromatic
    number `χ(G)` of the graph.

    A star coloring is a special type of distance - 1  coloring,
    For a coloring to be called a star coloring, it must satisfy
    two conditions:

    1. every pair of adjacent vertices receives distinct  colors
    (a distance-1 coloring)

    2. For any vertex v, any color that leads to a two-colored path
    involving v and three other vertices  is  impermissible  for  v.
    In other words, every path on four vertices uses at least three
    colors.

    Reference: Gebremedhin AH, Manne F, Pothen A. **What color is your Jacobian? Graph coloring for computing derivatives.** SIAM review. 2005;47(4):629-705.
"""
function greedy_star1_coloring(g::LightGraphs.AbstractGraph)
    v = nv(g)
    color = zeros(Int64, v)

    forbiddenColors = zeros(Int64, v+1)

    for vertex_i = vertices(g)

        for w in inneighbors(g, vertex_i)
            if color[w] != 0
                forbiddenColors[color[w]] = vertex_i
            end

            for x in inneighbors(g, w)
                if color[x] != 0
                    if color[w] == 0
                        forbiddenColors[color[x]] = vertex_i
                    else
                        for y in inneighbors(g, x)
                           if color[y] != 0
                                if y != w && color[y] == color[w]
                                    forbiddenColors[color[x]] = vertex_i
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end

        color[vertex_i] = find_min_color(forbiddenColors, vertex_i)
    end

    color
end

function find_min_color(forbiddenColors::AbstractVector, vertex_i::Integer)
    c = 1
    while (forbiddenColors[c] == vertex_i)
        c+=1
    end
    c
end
