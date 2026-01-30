# Option A: Get ArchiveBox with Docker Compose (recommended):
mkdir -p ~/archivebox/data && cd ~/archivebox
curl -fsSL 'https://docker-compose.archivebox.io' > docker-compose.yml   # edit options in this file as-needed
docker compose run archivebox init --setup
# docker compose run archivebox add 'https://example.com'
# docker compose run archivebox help
# docker compose up


# Option B: Or use it as a plain Docker container:
mkdir -p ~/archivebox/data && cd ~/archivebox/data
docker run -it -v $PWD:/data archivebox/archivebox init --setup
# docker run -it -v $PWD:/data archivebox/archivebox add 'https://webarchive.dev'
# docker run -it -v $PWD:/data archivebox/archivebox help
# docker run -it -v $PWD:/data -p 8000:8000 archivebox/archivebox


# Option C: Or install it with your preferred pkg manager (see Quickstart below for apt, brew, and more)
pip install archivebox
mkdir -p ~/archivebox/data && cd ~/archivebox/data
archivebox init --setup
# archivebox add 'https://example.com'
# archivebox help
# archivebox server 0.0.0.0:8000


# Option D: Or use the optional auto setup script to install it
curl -fsSL 'https://get.archivebox.io' | bash
