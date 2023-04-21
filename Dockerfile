FROM jupyter/minimal-notebook:latest

ENV CONFIG_NAME "climate"

COPY --chown=${NB_UID}:${NB_GID} generate-config.sh /home/${NB_USER}

RUN mamba install --yes \
    aiohttp \
    cartopy \
    cftime \
    dask \
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
    xarray \
    xesmf && \
    mamba clean --all --yes && \
    fix-permissions /home/${NB_USER}
