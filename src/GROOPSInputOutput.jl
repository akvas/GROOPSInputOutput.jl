module GROOPSInputOutput

  using Dates
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

  function savegrid(filename, data, a, f)
    gio.savegrid(filename, data, a, f)
  end

  function loadgridrectangular(filename)
    gio.loadgridrectangular(filename)
  end

  function loadpolygon(filename)
    gio.loadpolygon(filename)
  end

  function loadsphericalharmonics(filename)
    gio.loadsphericalharmonics(filename)
  end

  function loadtimesplines(filename, t::Dates.DateTime)
    gio.loadtimesplines(filename, t)
  end

  function loadnormals(filename)
    gio.loadnormals(filename)
  end

  function loadnormalsinfo(filename, fullinfo::Bool=false)
    gio.loadnormalsinfo(filename, fullinfo)
  end

  function loadtimeseries(filename)
    gio.loadtimeseries(filename)
  end
end
