#include "jlcxx/jlcxx.hpp"
#include "jlcxx/array.hpp"
#include "jlcxx/tuple.hpp"
#include "files/fileMatrix.h"
#include "files/fileGriddedData.h"


jlcxx::ArrayRef<double, 2> loadmatrix(const std::string& file_name)
{
  Matrix M;
  readFileMatrix(FileName(file_name), M);

  if(M.getType() == Matrix::SYMMETRIC)
    fillSymmetric(M);
  if(M.getType() == Matrix::TRIANGULAR)
    zeroUnusedTriangle(M);

  jl_value_t *array_type = jl_apply_array_type((jl_value_t*)jl_float64_type, 2);
  jl_array_t *x  = jl_alloc_array_2d(array_type, M.rows(), M.columns());
  double *xData = (double*)jl_array_data(x);
  memcpy(xData, M.field(), M.size() * sizeof(double));

  return jlcxx::ArrayRef<double, 2>(x);
}

void savematrix(const std::string& file_name, jlcxx::ArrayRef<double, 2> array)
{
  jl_array_t *x = array.wrapped();

  std::size_t rows = jl_array_dim(x, 0);
  std::size_t columns = jl_array_dim(x, 1);

  Matrix M(rows, columns);
  double *xData = (double*)jl_array_data(x);
  memcpy(M.field(), xData, M.size() * sizeof(double));

  writeFileMatrix(FileName(file_name), M);
}

JLCXX_MODULE define_julia_module(jlcxx::Module& mod)
{
  mod.method("loadmatrix", loadmatrix);
  mod.method("savematrix", savematrix);
}