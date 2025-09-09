# Node.js image ব্যবহার করুন
FROM node:18

# Java (OpenJDK 17) install করুন
RUN apt-get update && apt-get install -y openjdk-17-jdk

# কাজের ডিরেক্টরি সেট করুন
WORKDIR /app

# আপনার সব ফাইল কপি করুন
COPY . .

# Node.js dependency install করুন
RUN npm install

# পোর্ট এক্সপোজ করুন (যদি 3000 হয়)
EXPOSE 3000

# অ্যাপ রান করুন
CMD ["node", "server.js"]
