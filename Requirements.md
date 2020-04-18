# Requirements

This repository meets the following requirements: 

You want to design a continuous delivery architecture for a scalable and secure 3 tier Node application. 

1. Both web and API tiers should be exposed to the internet and DB tier should not be accessible from the internet. 
2. You need to create resources for all the tiers.
3. The architecture should be completely provisioned via some infrastructure as a code tool.
4. Presented solution must handle server (instance) failures.
5. Components must be updated without downtime in service.
6. The deployment of new code should be completely automated (bonus points if you create tests and include them into the pipeline).
6. The database and any mutable storage need to be backed up at least daily.
7. All relevant logs for all tiers need to be easily accessible (having them on the hosts is not an option)
8. Implement monitoring and logging using self-provisioned tools. Usage of managed services for monitoring/logging is not permitted.
9. You should be able to deploy it on one larger Cloud provider: AWS / Google Cloud / Azure / DigitalOcean / RackSpace.
10. The system should present relevant historical metrics to spot and debug bottlenecks.
11. The system should implement CDN to allow content distribution based on client location
