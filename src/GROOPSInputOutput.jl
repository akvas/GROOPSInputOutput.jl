module GROOPSInputOutput
  using CxxWrap
  @wrapmodule(joinpath("..", "deps", "build", "lib", "libgroopsio"))

  function __init__()
    @initcxx
  end

end
