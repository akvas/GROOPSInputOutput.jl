module GROOPSInputOutput

  using PyCall

  const gio = PyNULL()

  function __init__()
    copy!(gio, pyimport("groopsio"))
  end

  function loadmatrix(filename)
    gio.loadmatrix(filename)
  end

  function savematrix(filename, matrix, matrix_type="general", lower=false)
    gio.savematrix(filename, matrix, matrix_type=matrix_type, lower=lower)
  end

  function loadgrid(filename)
    gio.loadgrid(filename)
  end

  function loadpolygon(filename)
    gio.loadpolygon(filename)
  end
end
