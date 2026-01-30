$ docker plugin install lebokus/bindfs

# or to enable debug 
docker plugin install lebokus/bindfs DEBUG=1

archivebox-1  | [*] [2024-02-29 02:03:34] Archiving 1/1 URLs from added set...
archivebox-1  | Internal Server Error: /add/
archivebox-1  | Traceback (most recent call last):
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/core/handlers/exception.py", line 47, in inner
archivebox-1  |     response = get_response(request)
archivebox-1  |                ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/core/handlers/base.py", line 181, in _get_response
archivebox-1  |     response = wrapped_callback(request, *callback_args, **callback_kwargs)
archivebox-1  |                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/views/generic/base.py", line 70, in view
archivebox-1  |     return self.dispatch(request, *args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/utils/decorators.py", line 43, in _wrapper
archivebox-1  |     return bound_method(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/views/decorators/csrf.py", line 54, in wrapped_view
archivebox-1  |     return view_func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/contrib/auth/mixins.py", line 109, in dispatch
archivebox-1  |     return super().dispatch(request, *args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/views/generic/base.py", line 98, in dispatch
archivebox-1  |     return handler(request, *args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/usr/local/lib/python3.11/site-packages/django/views/generic/edit.py", line 142, in post
archivebox-1  |     return self.form_valid(form)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/core/views.py", line 290, in form_valid
archivebox-1  |     add(**input_kwargs)
archivebox-1  |   File "/app/archivebox/util.py", line 116, in typechecked_function
archivebox-1  |     return func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/main.py", line 693, in add
archivebox-1  |     archive_links(new_links, overwrite=False, **archive_kwargs)
archivebox-1  |   File "/app/archivebox/util.py", line 116, in typechecked_function
archivebox-1  |     return func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/extractors/__init__.py", line 236, in archive_links
archivebox-1  |     archive_link(to_archive, overwrite=overwrite, methods=methods, out_dir=Path(link.link_dir))
archivebox-1  |   File "/app/archivebox/util.py", line 116, in typechecked_function
archivebox-1  |     return func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/extractors/__init__.py", line 133, in archive_link
archivebox-1  |     write_link_details(link, out_dir=out_dir, skip_sql_index=False)
archivebox-1  |   File "/app/archivebox/util.py", line 116, in typechecked_function
archivebox-1  |     return func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/index/__init__.py", line 335, in write_link_details
archivebox-1  |     write_json_link_details(link, out_dir=out_dir)
archivebox-1  |   File "/app/archivebox/util.py", line 116, in typechecked_function
archivebox-1  |     return func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/index/json.py", line 99, in write_json_link_details
archivebox-1  |     atomic_write(str(path), link._asdict(extended=True))
archivebox-1  |   File "/app/archivebox/util.py", line 116, in typechecked_function
archivebox-1  |     return func(*args, **kwargs)
archivebox-1  |            ^^^^^^^^^^^^^^^^^^^^^
archivebox-1  |   File "/app/archivebox/system.py", line 108, in atomic_write
archivebox-1  |     os.chmod(path, int(OUTPUT_PERMISSIONS, base=8))
archivebox-1  | PermissionError: [Errno 1] Operation not permitted: '/data/archive/1709172214.318422/index.json'
$ docker volume create -d lebokus/bindfs -o sourcePath=$PWD -o map=$UID/0:@$UID/@0 [-o <any_bindfs_-o_option> ] bindfsvolume

$ docker volume ls
DRIVER              VOLUME NAME
local               2d75de358a70ba469ac968ee852efd4234b9118b7722ee26a1c5a90dcaea6751
local               842a765a9bb11e234642c933b3dfc702dee32b73e0cf7305239436a145b89017
local               9d72c664cbd20512d4e3d5bb9b39ed11e4a632c386447461d48ed84731e44034
local               be9632386a2d396d438c9707e261f86fd9f5e72a7319417901d84041c8f14a4d
local               e1496dfe4fa27b39121e4383d1b16a0a7510f0de89f05b336aab3c0deb4dda0e
lebokus/bindfs      bindfsvolume

git clone https://github.com/StudioEtrange/docker-volume-bindfs
cd docker-volume-bindfs
docker run -it --rm --volume=$(pwd):/go/src/github.com/StudioEtrange/docker-volume-bindfs golang:1.22.1-bullseye bash

# FROM INSIDE CONTAINER
cd /go/src/github.com/StudioEtrange/docker-volume-bindfs


# check status of used packaged from source code
go mod verify

# INIT Go modules management
go mod init

# SYNC package between vendor content and vendor.json 
go mod vendor

# FROM OUTSIDE CONTAINER
sudo chown -R $(id -u):$(id -g) vendor
sudo chown -R $(id -u):$(id -g) go.mod
sudo chown -R $(id -u):$(id -g) go.sum
git clone https://github.com/StudioEtrange/docker-volume-bindfs
cd docker-volume-bindfs
docker run -it --rm --volume=$(pwd):/go/src/github.com/StudioEtrange/docker-volume-bindfs golang:1.22.1-bullseye bash

# FROM INSIDE CONTAINER
cd /go/src/github.com/StudioEtrange/docker-volume-bindfs


# check status of used packaged from source code
go mod verify

# INIT Go modules management
go mod init

# SYNC package between vendor content and vendor.json 
go mod vendor

# FROM OUTSIDE CONTAINER
sudo chown -R $(id -u):$(id -g) vendor
sudo chown -R $(id -u):$(id -g) go.mod
sudo chown -R $(id -u):$(id -g) go.sum

docker run --privileged --rm tonistiigi/binfmt -install linux/arm64
docker run --privileged --rm tonistiigi/binfmt -install linux/amd64
docker plugin install ghcr.io/studioetrange/bindfs:latest-arm64
docker plugin install ghcr.io/studioetrange/bindfs:2.3a-arm64
docker plugin install ghcr.io/studioetrange/bindfs:latest-amd64

