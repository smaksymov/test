use_frameworks!

def shared_pods
    pod 'RxSwift'
    pod 'RxCocoa'
end

target 'testProject' do
  shared_pods
	target 'testProjectTests' do
			inherit! :complete
	end
	target 'testProjectUITests' do
			inherit! :complete
	end
end
