# Step 2: Infer the base image
FROM node:18-bullseye

# Step 8: Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Step 4: Install required packages
# No additional OS-level packages are specified, so we will proceed with Node.js environment

# Step 8: Create work directory
WORKDIR /usr/src/app

# Step 8: Copy repository files
COPY . .

# Step 8: Install npm packages
RUN npm install

# Step 8: Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]