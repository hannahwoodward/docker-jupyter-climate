FROM jupyter/minimal-notebook:python-3.10

ENV CONFIG_NAME "climate"

COPY --chown=${NB_UID}:${NB_GID} generate-config.sh /home/${NB_USER}

# Correct functioning of xesmf requires:
# python=3.10, esmf=8.3.1, numba, numpy=1.24.4
RUN mamba install --yes \
    aiohttp \
    cartopy \
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
    fix-permissions /home/${NB_USER}

# Replace np.int with int in windspharm library
RUN sed -i "s|np.int|int|" /opt/conda/lib/python3.10/site-packages/windspharm/_common.py
