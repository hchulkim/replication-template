
# Run the commented code below to do the examples below
import Pkg
Pkg.add(["ProgressMeter", "Distributed", "Chairmarks", "TimerOutputs", "JET", "DispatchDoctor", "PrecompileTools", "OhMyThreads", "ThreadPinning"])

# Example for ProfressMeter
using ProgressMeter
using Distributed

@showprogress for i in 1:100
    sleep(0.1)
end

prog = ProgressUnknown(desc="Titles read:")
for val in ["a", "b", "c"]
    next!(prog)
    if val == "c"
        finish!(prog)
        break
    end
    sleep(0.1)
end

# Example for Chairmarks
using Chairmarks

@b rand(1000) # fastest runtime
@be rand(1000) # full runtime results

# Example for JET and DispatchDoctor
using JET
using DispatchDoctor

@report_opt foldl(+, Any[]; init=0)

@stable function relu(x)
    if x > 0
        return x
    else
        return 0.0
    end
end

relu(0) # This should throw an error for any type instability

@stable begin

    f() = rand(Bool) ? 0 : 1.0
    f(x) = x

    module A
        # Will apply to code inside modules:
        g(; a, b) = a + b

        # Will recursively apply to included files:
        include("myfile.jl")

        module B
            # as well as nested submodules!

            # `@unstable` inverts `@stable`:
            using DispatchDoctor: @unstable
            @unstable h() = rand(Bool) ? 0 : 1.0

            # This can also apply to code blocks:
            @unstable begin
                h(x::Int) = rand(Bool) ? 0 : 1.0
                # ^ And target specific methods
            end
        end
    end
end

# Example for OhMyThreads
using OhMyThreads

# Variant 2: macro API
function mc_parallel_macro(N; ntasks=nthreads())
    M = @tasks for i in 1:N
        @set begin
            reducer=+
            ntasks=ntasks
        end
        rand()^2 + rand()^2 < 1.0
    end
    pi = 4 * M / N
    return pi
end

N = 100_000_000

@b mc_parallel($N; ntasks=1) # single-threaded version
@b mc_parallel($N)

# Example for ThreadPinning (only for Linux)
using ThreadPinning