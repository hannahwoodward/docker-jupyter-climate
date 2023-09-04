FROM jupyter/minimal-notebook:python-3.10

ENV CONFIG_NAME "climate"

COPY --chown=${NB_UID}:${NB_GID} generate-config.sh /home/${NB_USER}

# Specific versions added for some packages for correct functioning of:
# - cartopy => v0.21.1 (downgrade from v0.22.0) to prevent error:
#   'GeometryCollection' object is not subscriptable (cartopy calling shapely)
# - xesmf   => python=3.10, esmf=8.3.1, numba, numpy=1.24.4
RUN mamba install --yes \
    aiohttp \
    cartopy=0.21.1 \
    cftime \
    dask \
    esmf=8.3.1 \
    matplotlib \
    nc-time-axis \
    nco \
    netcdf4 \
    numba \
    numpy=1.24.4 \
    openpyxl \
    pandas \
    pynco \
    scipy \
    seaborn \
    statsmodels \
    urllib3 \
    windspharm \
    xarray \
    xesmf && \
    mamba clean --all --yes && \
    pip install \
    thermofeel && \
    fix-permissions /home/${NB_USER}

# Replace np.int with int in windspharm library
RUN sed -i "s|np.int|int|" /opt/conda/lib/python3.10/site-packages/windspharm/_common.py
