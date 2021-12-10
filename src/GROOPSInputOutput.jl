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

  function savegrid(filename, data, a::Number, f::Number)
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

  function loadnormalsinfo(filename, return_full_info::Bool=false)
    gio.loadnormalsinfo(filename, return_full_info=return_full_info)
  end

  function loadtimeseries(filename)
    gio.loadtimeseries(filename)
  end
end
