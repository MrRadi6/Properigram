
# Properigram

## iOS application build using swiftui and used MVVM clean architecture

## Architecture layers

- Domain contain app entities and use cases
- Modules contain app screens view and view-model
- Data contain repositories and Network

## Flow

View -> viewModel -> UseCase -> Data

## Potential improvements

- Use coordinator pattern to handle app navigation
- Set Fonts in a constants file or extensions 'might not be used for the task but it will be better for scalability'
- Set Colors in extension 'might not be used for the task but it will be better for scalability'
- Collect shared constants sizes into constants of theme file
- Write unit test for network layer will be a good improvement
- In properties list module, it will be better to remove ID coupling between the domain and the presentation
