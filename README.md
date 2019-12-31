# django-production-quickstart
A quick-start repository that sets you up with a production-ready Django site deployed on AWS Lambda

## Getting Started

These instructions will get you a copy of the project up and running on your local machine 
for development and testing purposes. See deployment for notes on how to deploy 
the project on a live system.

### Prerequisites

This repository assumes Python 3, and running on Mac or Linux for now.
```
sudo apt-get install python3 awscli
```

### Installing

A step by step series of examples that tell you how to get a development env running.

1. Fork the [Django Production Quick-Start repository](https://github.com/Sheepzez/django-production-quickstart).

2. Choose and set a name for your project (letters and spaces only, keep it short):

    ```
    export DJANGO_PROD_QUICKSTART_NAME="My New Website"
    ```

3. Rename the Django app module and mentions of Django Production Quick-Start:

    ```
    ./set_up_new_project.sh && git add -A && git commit -m "Finish set-up using Django Production Quick-Start"
    ```

4. Create a Python virtual environment to use:

    ```
    # Uses an environment variable set up when you ran ./set_up_new_project.sh
    python3 -m venv "~/envs/$PYTHON_MODULE_QUICKSTART_NAME" && source ~/envs/$PYTHON_MODULE_QUICKSTART_NAME/bin/activate
    ```

5. Install required dependencies

    ```
    pip install -r requirements.txt
    ```
   
6. Apply the database migrations locally

    ```
    python manage.py migrate
    ```

### Each development session

1. At the start of each development session, enable the virtual environment in your terminal.

    ```
    # Specific env name will have been printed when you first ran ./set_up_new_project.sh
    source ~/envs/"$PYTHON_MODULE_QUICKSTART_NAME"/bin/activate
    ```

2. Run the dev server locally

    ```
    python manage.py runserver
    # Now open localhost:8000 on your browser
    ```
   
3. Open [localhost:8000](localhost:8000) in your browser
    1. When first opening, you should see your chosen name as the page title

## TODO: Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

1. (If using GitHub) Get a GitHub [personal access token](https://github.com/settings/tokens) with `repo` scope permission

    ```
    export GITHUB_OAUTH_TOKEN=<your token>
    ```
    
2. Set environment variables pointing to your repository (examples below)

    ```
    export GITHUB_USER=sheepzez
    export GITHUB_REPO=django-production-quickstart
    ```

3. Set up some AWS credentials

    ```
    aws configure
    ```

4. Create the CodePipeline pipeline, and commit the definition file

    ```
    ./create_pipeline.sh && git add -A && git commit -m "Update pipeline stack definition"
    ```

## Built With

* [Django](https://www.djangoproject.com) - The web framework used

## TODO: Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## TODO: Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Isaac Jordan** - *Initial work* - [Website](https://isaacjordan.me/)

See also the list of [contributors](https://github.com/Sheepzez/django-production-quickstart/graphs/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* PurpleBooth for this [README template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
* symphoniacloud for [CloudFormation/CodePipeline examples](https://github.com/symphoniacloud/github-codepipeline)
