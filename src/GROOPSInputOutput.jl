module GROOPSInputOutput
  using CxxWrap
  @wrapmodule(joinpath(dirname(dirname(@__FILE__)), "deps", "lib", "libgroopsio"))

  function __init__()
    @initcxx
  end

end
