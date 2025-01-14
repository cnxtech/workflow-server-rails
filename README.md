# Workflow service

[![](https://images.microbadger.com/badges/image/suldlss/workflow-server.svg)](https://microbadger.com/images/suldlss/workflow-server "Get your own image badge on microbadger.com")

This is a Rails-based workflow service that replaced SDR's Java-based workflow service.  It is consumed by the users of dor-workflow-client (argo, hydrus, hydra_etd, pre-assembly, dor-indexing-app, robots) and *soon* the goobi application (currently proxying through dor-services-app).

## Build
Build the production image
```
docker build -t suldlss/workflow-server:latest .
```

## Run the development stack
```
$ docker-compose up -d
[FIRST RUN]
$ docker-compose run app rake db:setup
$ docker-compose stop
$ docker-compose up -d
[ -------- ]
```

If you want to connect to the container:
```
$ docker ps (to retrieve the container id)
$ docker exec -it (container id) /bin/sh
```

Testing:

```
docker-compose run -e "RAILS_ENV=test" app rake db:create db:migrate
docker-compose run -e "RAILS_ENV=test" app rake spec
```

## Routes:
`GET    /:repo/objects/:druid/lifecycle` - Returns the milestones in the lifecycle that have been completed


`POST   /:repo/objects/:druid/versionClose` - Set all versioningWF steps to 'complete' and starts a new accessionWF unless `create-accession=false` is passed as a parameter.


These methods deal with the workflow for a single object
```
POST   /objects/:druid/workflows/:workflow
GET    /:repo/objects/:druid/workflows
GET    /:repo/objects/:druid/workflows/:workflow
DELETE /:repo/objects/:druid/workflows/:workflow
```

These methods deal with a single step for a single object
```
PUT    /:repo/objects/:druid/workflows/:workflow/:process
GET    /:repo/objects/:druid/workflows/:workflow/:process
```

`GET    /workflow_archive` - Deprecated. Currently just returns a count of the number of items/versions for the workflow
`PUT    /:repo/objects/:druid/workflows/:workflow` - Deprecated. Use version without repo parameter instead.

These processes are used by robot-master to discover which steps need to be performed.
```
GET    /workflow_queue/lane_ids
GET    /workflow_queue/all_queued
GET    /workflow_queue
```
