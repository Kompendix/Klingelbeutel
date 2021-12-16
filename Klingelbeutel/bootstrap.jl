pwd() == joinpath(@__DIR__, "bin") && cd(@__DIR__) # allow starting app from bin/ dir

using Klingelbeutel
push!(Base.modules_warned_for, Base.PkgId(Klingelbeutel))
Klingelbeutel.main()
