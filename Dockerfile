FROM jupyter/minimal-notebook:python-3.10

ENV CONFIG_NAME "climate"

COPY --chown=${NB_UID}:${NB_GID} generate-config.sh /home/${NB_USER}

# python 3.10 & esmf 8.3.1 required for correct functioning of xesmf
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
    numpy \
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
